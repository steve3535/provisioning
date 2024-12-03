# Dockerfile
FROM python:3.12-slim

ARG http_proxy=http://vsl-pro-squ-001:3128
ARG https_proxy=http://vsl-pro-squ-001:3128
ARG no_proxy=.lalux.local,localhost,127.0.0.1
ARG NO_PROXY=.lalux.local,localhost,127.0.0.1

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    python3-dev \
    libssl-dev \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Copy the certificate into the container
COPY certs/lalux-sha256-4096.pem /usr/local/share/ca-certificates/lalux-sha256-4096.crt

# Update the CA certificates
RUN update-ca-certificates

# Set working directory
WORKDIR /app

# Copy requirements first to leverage Docker cache
COPY backend/requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir --trusted-host pypi.org --trusted-host files.pythonhosted.org -r requirements.txt

# Copy application code
COPY backend/ .

# Copy necessary terraform files
COPY terraform/ /terraform/

# Set environment variables
ENV FLASK_APP=app.py
ENV FLASK_ENV=production
ENV PYTHONUNBUFFERED=1
ENV http_proxy=http://vsl-pro-squ-001:3128
ENV https_proxy=http://vsl-pro-squ-001:3128
ENV HTTP_PROXY=http://vsl-pro-squ-001:3128
ENV HTTPS_PROXY=http://vsl-pro-squ-001:3128
ENV no_proxy=.lalux.local,localhost,127.0.0.1,lu687,lu652,lu651
ENV NO_PROXY=.lalux.local,localhost,127.0.0.1,lu687,lu652,lu651

# Expose port
EXPOSE 5500

# Run the application with gunicorn
CMD ["python","app.py","--host","0.0.0.0"]
