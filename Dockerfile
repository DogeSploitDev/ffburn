# Use the official Python image from the Docker Hub
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Install git
RUN apt-get update && apt-get install -y git

# Clone the SpiderFoot repository
RUN git clone https://github.com/smicallef/spiderfoot.git

# Change the working directory to the cloned repository
WORKDIR /app/spiderfoot

# Install the dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port that SpiderFoot will run on
EXPOSE 5001

# Run SpiderFoot
CMD ["python3", "./sf.py", "-l", "127.0.0.1:5001"]
