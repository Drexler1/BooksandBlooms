import logging
from collections import deque
from datetime import datetime
import pytz

# In-memory circular buffer for recent application logs (last 300 entries)
log_buffer = deque(maxlen=300)

class DeveloperLogBufferHandler(logging.Handler):
    """Logging handler that captures records in an in-memory deque for real-time monitoring."""
    def __init__(self, capacity=300):
        super().__init__()
        self.capacity = capacity

    def emit(self, record):
        try:
            msg = self.format(record)
            pht = pytz.timezone("Asia/Manila")
            timestamp = datetime.now(pht).strftime("%Y-%m-%d %H:%M:%S")
            log_buffer.append({
                "timestamp": timestamp,
                "level": record.levelname,
                "name": record.name,
                "message": msg,
            })
        except Exception:
            self.handleError(record)

# Singleton handler instance
log_handler = DeveloperLogBufferHandler(capacity=300)
formatter = logging.Formatter("[%(asctime)s] %(levelname)s in %(module)s: %(message)s")
log_handler.setFormatter(formatter)
log_handler.setLevel(logging.INFO)

def attach_log_handler(app):
    """Attach the developer buffer handler to the Flask app logger and root logger."""
    app.logger.setLevel(logging.INFO)
    if log_handler not in app.logger.handlers:
        app.logger.addHandler(log_handler)
    root_logger = logging.getLogger()
    if root_logger.level > logging.INFO:
        root_logger.setLevel(logging.INFO)
    if log_handler not in root_logger.handlers:
        root_logger.addHandler(log_handler)
