# gunicorn.conf.py — repo root, used by both Render (via render.yml) and
# Railway (via Dockerfile CMD).
#
# Railway (Standard plan, 2 GB RAM):  TF/DeepFace loads fine at startup.
# Render Starter (512 MB):            TF is lazy-loaded per-request; the
#                                     post_fork warm-up is intentionally
#                                     skipped here because it would OOM-kill
#                                     the worker before any request is served.
#                                     The _warm_deepface() daemon thread in
#                                     app.py handles warming in the background
#                                     without blocking gunicorn startup.

bind           = "0.0.0.0:8080"   # overridden at runtime by --bind in start cmd
workers        = 1
threads        = 4
timeout        = 120
preload_app    = True              # import app once in master, share across workers
worker_class   = "gthread"         # thread-based workers — better for I/O-heavy routes