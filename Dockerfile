FROM python:3.10-slim

WORKDIR /app

# Install system dependencies (VERY IMPORTANT for ML projects)
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip
RUN pip install --upgrade pip

# Copy requirements first (better caching)
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# Copy full project
COPY . .

EXPOSE 5000

# Run FastAPI with uvicorn (production-safe)
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "5000"]