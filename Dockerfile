# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
RUN pip3 install -r requirements.txt

# Install xvfb and noVNC
RUN apt-get update && apt-get install -y \
    xvfb \
    novnc \
    x11vnc

# Copy the start script into the container at /app
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Expose the port the app runs on
EXPOSE 5001
EXPOSE 6080

# Run the start script
CMD ["/app/start.sh"]
