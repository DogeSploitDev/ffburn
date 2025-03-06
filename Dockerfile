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
    wget \
    unzip \
    fluxbox

# Clone the repository
RUN git clone https://github.com/smicallef/spiderfoot.git /app


# Activate the virtual environment and install any needed packages specified in requirements.txt
RUN pip install -r /app/requirements.txt

# Download and set up noVNC
RUN mkdir -p /usr/share/novnc && \
    wget -qO- https://github.com/novnc/noVNC/archive/refs/tags/v1.3.0.tar.gz | tar xvz -C /usr/share/novnc --strip-components=1

# Expose the ports the app runs on
EXPOSE 5001
EXPOSE 6080

# Start script
CMD /bin/bash -c "\
    Xvfb :99 -screen 0 1280x1024x24 & \
    fluxbox -display :99 & \
    x11vnc -display :99 -forever -nopw -create & \
    websockify --web=/usr/share/novnc/ 6080 localhost:5900 & \
    DISPLAY=:99 python3 /app/sf.py -l 127.0.0.1:5001"
