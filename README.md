# Kubernetes hello-world

This hello-world app has 2 endpoints:
- '/' which displays an "Hello World!" message with the name of the pod it runs
    into and its current version. It also performs heavy computations every time it is accessed.
- '/health' which provides a basic health check

# Installation

This application is a Python app. It runs smoothly in Python 3.5 and Python 2.7.

Clone the repo to a folder:
- `mkdir $HOME/passenger-app`
- `cd $HOME/passenger-app`
- `git clone git@github.com:praveenkanna/passenger-nginx-docker.git .`

To run it, build the image frst:

- `docker build -t <some-name> . `

To run it:

- `docker run -d -p 80:80 <some-name>`