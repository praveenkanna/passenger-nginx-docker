# Kubernetes hello-world

This hello-world app has 2 endpoints:
- '/' which displays an "Hello World!" message with the name of the pod it runs
    into and its current version. It also performs heavy computations every time it is accessed.
- '/health' which provides a basic health check

# Tag and PUSH docker image to google container registry

This application is a Python app. It runs smoothly in Python 3.5 and Python 2.7.

Clone the repo to a folder:
- `mkdir $HOME/passenger-app`
- `cd $HOME/passenger-app`
- `git clone git@github.com:praveenkanna/passenger-nginx-docker.git .`

To run it, build the image frst:

- `docker build -t <some-name> . `

configure your local Docker client to be able to authenticate to Container Registry: 
- `export PROJECT_ID="$(gcloud config get-value project -q)"`
- `gcloud auth configure-docker`

Next, tag the local Docker image for uploading:

- `docker tag simple-web-app:latest "gcr.io/${PROJECT_ID}/simple-web-app:v1"`

Finally, push the Docker image to your private Container Registry:

- `docker push "gcr.io/${PROJECT_ID}/simple-web-app:v1"`

# Launch GKE Cluster

- `cd $HOME/passenger-app`
- `mkdir -p terraform`
- `cd terraform`

Run Terraform commands to create GKE cluster in gcloud

- `terraform init`
- `terraform plan`
- `terraform apply`

# Deploy the Dockerized python+passenger+nginx app in GKE Cluster

First, configure kubectl to use the newly created cluster:

- `gcloud container clusters get-credentials "${PROJECT_ID}-gke" --region us-east1`

Deploy all kubernetes manifests file:

- `kubectl create -f manifests/`

Wait for sometime to activate the certificate manager and browse:

- `https://kubedocker.xyz/`