import os
import sys
import time
import hmac
import platform
import shutil
import threading
import gc
from datetime import datetime, timedelta
from flask import Blueprint, render_template, jsonify, request, session, redirect, url_for, current_app
from MySQLdb.cursors import DictCursor

from developer import log_buffer

# Blueprint creation
developer_bp = Blueprint(
    "developer",
    __name__,
    template_folder="../templates/developer",
    url_prefix="/developer"
)

# Record server boot time
_SERVER_START_TIME = time.time()
_mysql_ref = None

# -- PIN brute-force tracking (in-memory, per IP) ----------------------------
# { ip: {"attempts": int, "lockout_until": float | None} }
_pin_attempts = {}
_PIN_MAX_ATTEMPTS = 5
_PIN_LOCKOUT_SECONDS = 600  # 10 minutes

# Optional psutil for detailed RAM/CPU tracking
try:
    import psutil
except ImportError:
    psutil = None


def get_db():
    """Retrieve MySQL extension instance from module ref or current_app."""
    return _mysql_ref or current_app.extensions.get("mysql")


def init_developer_bp(app, mysql_instance=None):
    """Initialize and register the developer blueprint with the Flask app."""
    global _mysql_ref
    if mysql_instance is not None:
        _mysql_ref = mysql_instance
        if not hasattr(app, "extensions"):
            app.extensions = {}
        app.extensions["mysql"] = mysql_instance

    from developer import attach_log_handler
    attach_log_handler(app)

    # Exempt internal telemetry and developer endpoints from CSRF
    if "csrf" in app.extensions:
        app.extensions["csrf"].exempt(developer_bp)

    app.register_blueprint(developer_bp)
    return developer_bp


def _get_correct_pin():
    """Return the configured DEV_CONSOLE_PIN from env."""
    return str(os.environ.get("DEV_CONSOLE_PIN", "")).strip()


def _pin_check(submitted):
    """Constant-time comparison of submitted PIN against the configured PIN."""
    correct = _get_correct_pin()
    if not correct or len(correct) != 6 or not correct.isdigit():
        return False
    return hmac.compare_digest(submitted, correct)


def _ip_lockout_state(ip):
    """Return the brute-force state for the given IP."""
    state = _pin_attempts.get(ip, {"attempts": 0, "lockout_until": None})
    if state["lockout_until"] and time.time() > state["lockout_until"]:
        state = {"attempts": 0, "lockout_until": None}
        _pin_attempts[ip] = state
    return state


def _is_dev_authenticated():
    """Check that the current session has a valid developer authentication token."""
    return session.get("dev_authenticated") is True


# -- Before-request guard -----------------------------------------------------
@developer_bp.before_request
def require_dev_auth():
    """
    Gate every /developer route behind the Developer PIN session.
    The regular admin/manager session is irrelevant here.
    """
    if request.endpoint in ("developer.dev_login", "developer.dev_logout"):
        return

    if not _is_dev_authenticated():
        if request.path.startswith("/developer/api/"):
            return jsonify({"status": "error", "message": "Developer authentication required."}), 403
        return redirect(url_for("developer.dev_login"))


# -- PIN Login ----------------------------------------------------------------
@developer_bp.route("/login", methods=["GET", "POST"])
def dev_login():
    """Dedicated 6-digit PIN login for the Developer Console."""
    if _is_dev_authenticated():
        return redirect(url_for("developer.dashboard"))

    error = None
    ip = request.remote_addr or "unknown"

    if request.method == "POST":
        state = _ip_lockout_state(ip)

        if state["lockout_until"] and time.time() < state["lockout_until"]:
            remaining = int(state["lockout_until"] - time.time())
            mins = remaining // 60
            secs = remaining % 60
            error = "Too many failed attempts. Try again in {}m {}s.".format(mins, secs)
        else:
            digits = "".join(
                request.form.get("d{}".format(i), "").strip() for i in range(1, 7)
            )
            if _pin_check(digits):
                session["dev_authenticated"] = True
                session.permanent = True
                _pin_attempts.pop(ip, None)
                current_app.logger.info("[developer] Console unlocked from IP {}".format(ip))
                return redirect(url_for("developer.dashboard"))
            else:
                state["attempts"] = state.get("attempts", 0) + 1
                if state["attempts"] >= _PIN_MAX_ATTEMPTS:
                    state["lockout_until"] = time.time() + _PIN_LOCKOUT_SECONDS
                    error = "Too many failed attempts. Locked for {} minutes.".format(_PIN_LOCKOUT_SECONDS // 60)
                    current_app.logger.warning(
                        "[developer] PIN brute-force lockout triggered for IP {}".format(ip)
                    )
                else:
                    remaining_tries = _PIN_MAX_ATTEMPTS - state["attempts"]
                    plural = "s" if remaining_tries != 1 else ""
                    error = "Incorrect PIN. {} attempt{} remaining.".format(remaining_tries, plural)
                _pin_attempts[ip] = state

    return render_template("dev_login.html", error=error)


# -- PIN Logout ---------------------------------------------------------------
@developer_bp.route("/logout", methods=["POST"])
def dev_logout():
    """Clear the developer session and return to the PIN login screen."""
    session.pop("dev_authenticated", None)
    current_app.logger.info("[developer] Developer Console session ended.")
    return redirect(url_for("developer.dev_login"))


# -- Main Console -------------------------------------------------------------
@developer_bp.route("")
@developer_bp.route("/")
def dashboard():
    """Render the Developer Super Admin Monitoring Dashboard."""
    return render_template("dashboard.html")


@developer_bp.route("/api/metrics", methods=["GET"])
def get_system_metrics():
    """Return live system telemetry, memory usage, disk storage, and DB latency."""
    now = time.time()
    uptime_seconds = int(now - _SERVER_START_TIME)
    uptime_str = str(timedelta(seconds=uptime_seconds))

    # Disk usage
    try:
        disk = shutil.disk_usage(os.getcwd())
        total_gb = round(disk.total / (1024 ** 3), 2)
        used_gb = round(disk.used / (1024 ** 3), 2)
        free_gb = round(disk.free / (1024 ** 3), 2)
        disk_pct = round((disk.used / disk.total) * 100, 1)
    except Exception:
        total_gb = used_gb = free_gb = disk_pct = 0

    # Memory & Process usage
    mem_used_mb = 0
    mem_total_mb = 0
    mem_pct = 0
    cpu_pct = 0
    process_rss_mb = 0

    if psutil:
        try:
            vmem = psutil.virtual_memory()
            mem_total_mb = round(vmem.total / (1024 ** 2), 1)
            mem_used_mb = round(vmem.used / (1024 ** 2), 1)
            mem_pct = vmem.percent
            cpu_pct = psutil.cpu_percent(interval=None)
            proc = psutil.Process()
            process_rss_mb = round(proc.memory_info().rss / (1024 ** 2), 1)
        except Exception:
            pass
    else:
        # Fallback estimation using GC and platform info
        mem_used_mb = round(sys.getsizeof(gc.get_objects()) / (1024 ** 2), 1)

    # Database latency and health test
    mysql = get_db()
    db_status = "Disconnected"
    db_latency_ms = None
    if mysql:
        try:
            t0 = time.perf_counter()
            conn = mysql.connection
            cur = conn.cursor()
            cur.execute("SELECT 1")
            cur.fetchone()
            cur.close()
            db_latency_ms = round((time.perf_counter() - t0) * 1000, 2)
            db_status = "Connected"
        except Exception as exc:
            db_status = f"Error: {str(exc)[:40]}"

    return jsonify({
        "status": "success",
        "timestamp": datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
        "server": {
            "os": f"{platform.system()} {platform.release()} ({platform.machine()})",
            "python": platform.python_version(),
            "uptime": uptime_str,
            "uptime_seconds": uptime_seconds,
            "active_threads": threading.active_count(),
            "gc_objects": len(gc.get_objects()),
        },
        "resources": {
            "cpu_percent": cpu_pct,
            "memory_used_mb": mem_used_mb,
            "memory_total_mb": mem_total_mb,
            "memory_percent": mem_pct,
            "process_rss_mb": process_rss_mb,
            "disk_total_gb": total_gb,
            "disk_used_gb": used_gb,
            "disk_free_gb": free_gb,
            "disk_percent": disk_pct,
            "has_psutil": psutil is not None,
        },
        "database": {
            "status": db_status,
            "latency_ms": db_latency_ms,
        }
    })


@developer_bp.route("/api/logs", methods=["GET"])
def get_logs():
    """Return filtered application logs captured in memory."""
    level_filter = request.args.get("level", "ALL").upper()
    search_query = request.args.get("search", "").lower()

    filtered = []
    for item in list(log_buffer):
        if level_filter != "ALL" and item["level"] != level_filter:
            continue
        if search_query and (search_query not in item["message"].lower() and search_query not in item["name"].lower()):
            continue
        filtered.append(item)

    # Return reverse chronological (newest first)
    return jsonify({
        "status": "success",
        "total_buffered": len(log_buffer),
        "count": len(filtered),
        "logs": list(reversed(filtered)),
    })


@developer_bp.route("/api/clear-logs", methods=["POST"])
def clear_logs():
    """Clear the in-memory log buffer."""
    log_buffer.clear()
    return jsonify({"status": "success", "message": "Log buffer cleared."})


@developer_bp.route("/api/test-log", methods=["POST"])
def test_log():
    """Emit a test log entry to verify the live log stream."""
    data = request.get_json(silent=True) or {}
    level = data.get("level", "INFO").upper()
    message = data.get("message", "Manual test log from Developer Console")

    if level == "DEBUG":
        current_app.logger.debug(f"[DevConsole Test] {message}")
    elif level == "WARNING":
        current_app.logger.warning(f"[DevConsole Test] {message}")
    elif level == "ERROR":
        current_app.logger.error(f"[DevConsole Test] {message}")
    else:
        current_app.logger.info(f"[DevConsole Test] {message}")

    return jsonify({"status": "success", "message": f"Emitted test log [{level}]"})


@developer_bp.route("/api/db-health", methods=["GET"])
def get_db_health():
    """Inspect MySQL database tables, record counts, and storage consumption."""
    mysql = get_db()
    if not mysql:
        return jsonify({"status": "error", "message": "MySQL connection unavailable"}), 500

    try:
        conn = mysql.connection
        cur = conn.cursor(DictCursor)
        # Fetch current database name
        cur.execute("SELECT DATABASE() AS current_db")
        db_name = (cur.fetchone() or {}).get("current_db", "pos_system")

        # Query information_schema for table statistics
        cur.execute("""
            SELECT 
                table_name AS table_name,
                table_rows AS table_rows,
                ROUND((data_length + index_length) / 1024 / 1024, 3) AS total_mb,
                ROUND(data_length / 1024 / 1024, 3) AS data_mb,
                ROUND(index_length / 1024 / 1024, 3) AS index_mb,
                table_collation AS collation,
                engine AS engine
            FROM information_schema.tables
            WHERE table_schema = %s
            ORDER BY (data_length + index_length) DESC
        """, (db_name,))
        tables = cur.fetchall()

        total_db_mb = sum(float(t.get("total_mb") or 0) for t in tables)
        total_rows = sum(int(t.get("table_rows") or 0) for t in tables)

        cur.close()
        return jsonify({
            "status": "success",
            "database_name": db_name,
            "table_count": len(tables),
            "total_size_mb": round(total_db_mb, 2),
            "total_rows": total_rows,
            "tables": tables,
        })
    except Exception as exc:
        current_app.logger.error(f"[developer.db-health] Query failed: {exc}")
        return jsonify({"status": "error", "message": str(exc)}), 500


@developer_bp.route("/api/security-audit", methods=["GET"])
def get_security_audit():
    """Retrieve failed login attempts, account lockouts, and biometric mismatches."""
    mysql = get_db()
    if not mysql:
        return jsonify({"status": "error", "message": "MySQL connection unavailable"}), 500

    lockouts = []
    face_mismatches = []
    try:
        conn = mysql.connection
        cur = conn.cursor(DictCursor)

        # 1. Login attempts / Lockouts
        try:
            cur.execute("""
                SELECT attempt_key, fail_count, locked_until, last_attempt
                FROM login_attempts
                ORDER BY last_attempt DESC
                LIMIT 30
            """)
            lockouts = cur.fetchall()
            for row in lockouts:
                if row.get("locked_until") and isinstance(row["locked_until"], datetime):
                    row["is_currently_locked"] = row["locked_until"] > datetime.now()
                    row["locked_until"] = row["locked_until"].strftime("%Y-%m-%d %H:%M:%S")
                else:
                    row["is_currently_locked"] = False
                    row["locked_until"] = None
                if row.get("last_attempt") and isinstance(row["last_attempt"], datetime):
                    row["last_attempt"] = row["last_attempt"].strftime("%Y-%m-%d %H:%M:%S")
        except Exception as e:
            current_app.logger.warning(f"[developer.security-audit] login_attempts query: {e}")

        # 2. Face mismatches
        try:
            cur.execute("""
                SELECT m.id, m.employee_id, m.attempted_at, m.distance_score, m.ip_address, m.user_agent,
                       e.full_name, e.role
                FROM face_mismatch_log m
                LEFT JOIN employees e ON m.employee_id = e.employee_id
                ORDER BY m.attempted_at DESC
                LIMIT 30
            """)
            face_mismatches = cur.fetchall()
            for row in face_mismatches:
                if row.get("attempted_at") and isinstance(row["attempted_at"], datetime):
                    row["attempted_at"] = row["attempted_at"].strftime("%Y-%m-%d %H:%M:%S")
        except Exception as e:
            current_app.logger.warning(f"[developer.security-audit] face_mismatch query: {e}")

        cur.close()
        return jsonify({
            "status": "success",
            "lockouts": lockouts,
            "face_mismatches": face_mismatches,
        })
    except Exception as exc:
        current_app.logger.error(f"[developer.security-audit] Failed: {exc}")
        return jsonify({"status": "error", "message": str(exc)}), 500


@developer_bp.route("/api/run-gc", methods=["POST"])
def run_garbage_collection():
    """Trigger Python garbage collection to free unreferenced memory."""
    before_objects = len(gc.get_objects())
    t0 = time.perf_counter()
    collected = gc.collect()
    duration_ms = round((time.perf_counter() - t0) * 1000, 2)
    after_objects = len(gc.get_objects())

    msg = f"GC freed {collected} objects in {duration_ms}ms (objects: {before_objects} -> {after_objects})"
    current_app.logger.info(f"[developer.gc] {msg}")

    return jsonify({
        "status": "success",
        "collected_objects": collected,
        "duration_ms": duration_ms,
        "before_count": before_objects,
        "after_count": after_objects,
        "message": msg
    })
