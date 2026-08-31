# gunicorn.conf.py — placed in repo root, referenced by Dockerfile CMD
#
# Fixes the TF re-trace cold-start: gunicorn forks the master process, and
# TF's graph/session state does not survive fork() cleanly.  post_fork()
# runs inside each worker after the fork, so the warm-up executes in the
# correct process context.

bind    = "0.0.0.0:8080"   # overridden at runtime by $PORT via CMD
workers = 1
threads = 4
timeout = 120
preload_app = True


def post_fork(server, worker):
    """Re-warm FaceNet inside every forked worker process."""
    try:
        import numpy as np
        from deepface import DeepFace

        DeepFace.represent(
            np.zeros((160, 160, 3), dtype=np.uint8),
            model_name="Facenet",
            detector_backend="skip",
            enforce_detection=False,
        )
        server.log.info("[post_fork] FaceNet warm complete in worker %s", worker.pid)
    except Exception as exc:
        server.log.warning("[post_fork] warm failed (non-fatal): %s", exc)
