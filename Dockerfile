FROM python:3.11-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    gcc \
    libgl1 \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    default-libmysqlclient-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Bake FaceNet weights into the image at build time so the first
# clock-in is fast (Railway has enough RAM to hold TF + the model).
RUN python -c "\
from deepface import DeepFace; \
import numpy as np; \
DeepFace.represent(np.zeros((160,160,3), dtype=np.uint8), model_name='Facenet', enforce_detection=False)"

EXPOSE 8080

# Railway: more RAM → more threads, warm preload is safe
CMD ["gunicorn", "app:app", \
     "--bind", "0.0.0.0:8080", \
     "--workers", "1", \
     "--threads", "4", \
     "--timeout", "120", \
     "--preload"]