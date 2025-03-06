# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Install necessary packages
RUN apt-get update && apt-get install -y \
    git \
    xvfb \
    x11vnc \
    novnc \
    websockify \
    python3-venv

# Clone the repository
RUN git clone https://github.com/smicallef/spiderfoot.git /app

# Create a virtual environment
RUN python3 -m venv venv

# Activate the virtual environment and install any needed packages specified in requirements.txt
RUN /bin/bash -c "source venv/bin/activate && pip install -r /app/requirements.txt"

# Expose the ports the app runs on
EXPOSE 5001
EXPOSE 6080

# Start script
CMD /bin/bash -c "\
    source venv/bin/activate && \
    Xvfb :99 -screen 0 1024x768x16 & \
    x11vnc -display :99 -forever -nopw -create & \
    websockify --web=/usr/share/novnc/ 6080 localhost:5900 & \
    DISPLAY=:99 python3 /app/sf.py -l 127.0.0.1:5001"
