# Use the official Python image
FROM python:3

# Set the working directory
WORKDIR /data

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3-distutils \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY . .

# Run database migrations
RUN python manage.py migrate

# Expose the application port
EXPOSE 8010

# Start the application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8010"]
