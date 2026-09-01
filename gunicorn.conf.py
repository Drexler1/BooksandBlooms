# gunicorn.conf.py — Railway deployment
#
# preload_app = False so the worker starts immediately and can answer
# /ping and page requests right away. TensorFlow/DeepFace loads lazily
# in the background via the _warm_deepface() daemon thread in app.py.
# With preload_app = True the master process blocks on TF import (~60s)
# before forking any worker, causing every request to 499-timeout.

bind             = "0.0.0.0:8080"   # overridden at runtime by --bind in Dockerfile CMD
workers          = 1
threads          = 4
timeout          = 120               # Railway proxy hard-cuts at 30s anyway; keep reasonable
graceful_timeout = 30
keepalive        = 5
preload_app      = False             # workers start immediately; TF warms in background thread
worker_class     = "gthread"         # thread-based workers — better for I/O-heavy routes