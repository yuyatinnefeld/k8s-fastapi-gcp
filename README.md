# Kubernetes Simple Fastapi Project


## How to Run 🐳

Template for a Python FastAPI with Dockerfile and configuration for Kubernetes

## Tech Stacks
- Cloud Provider: GCP
- Backend Service: FastAPI
- DB: Postgresql (Cloud SQL)
- Cluster Management: GKE
- CICD: Gitlab

## Create a Postgres DB and GKE Cluster (Gitlab)
```bash
# we are using the vpc "vpc-mainnet" for the cloud sql instance

# details: 
cat .gitlab-ci.yml
```

## Test DB Connection 1 (Cloud Shell)
```bash
gcloud sql connect $INSTANCE_NAME --user=postgres --quiet
```

## Test DB Connection 2 (Local Terminal)
```bash
# download the Cloud SQL Proxy (terminal)
curl -o cloud_sql_proxy https://dl.google.com/cloudsql/cloud_sql_proxy.darwin.amd64

# make the proxy executable
chmod +x cloud_sql_proxy

# create proxy connection
./cloud_sql_proxy -instances=${POSTGRES_CONN_NAME}=tcp:3306

# open another terminal
pip install -r requirements.txt
uvicorn service.main:app --host 0.0.0.0 --port 8080 --reload
Navigate to http://localhost:8080/docs to test the API.
```

## Push the container image to Docker Hub (Local Terminal)

If desired, push the container to Docker Hub yourself, and change all references to the image accordingly.

```bash 
# show all activated ip addresses (public and private)
echo $(gcloud sql instances describe $INSTANCE_NAME --format 'value(ipAddresses.ipAddress)')
# update private_id (e.g. 10.5.48.7)
vi service/database.py

# update version
export VERSION="2.0.2"
# push the image into the repo
docker build -t yuya_simple_fastapi:$VERSION .
docker tag yuya_simple_fastapi:$VERSION yuyatinnefeld/yuya_simple_fastapi:$VERSION
docker push yuyatinnefeld/yuya_simple_fastapi:$VERSION

# test
docker run -p 8080:8080 --name k-fastapi yuyatinnefeld/yuya_simple_fastapi:$VERSION
```

You may also need to make the image public as well.

## Push the container image to Google Container Registry (Gitlab)
```bash
cat .gitlab-ci.yml
```

## Kubernetes deployment (Cloud Shell)
```bash
# connect with the cluter
gcloud config set project $PROJECT_ID
gcloud config set compute/zone europe-west1-b
gcloud container clusters get-credentials $CLUSTER_NAME --zone europe-west1-b

cd deploy

# update fastapi docker image version
vi api.yaml

# create config map with declarative way
kubectl create -f config-map.yaml

# view config maps
kubectl describe configmaps app-config

# deploy service
kubectl apply -f api.yaml
kubectl get pods --watch
```

If working locally, e.g. using `minikube`, use port forwarding to expose the service:
```bash
kubectl port-forward service/kf-api-svc 8080

verify the result

# open GCP webviewer
# example
https://8080-cs-e503cce9-67f8-4ec8-a12f-469da33403a1.cs-europe-west1-iuzs.cloudshell.dev/docs
```


## Teardown
```bash
# clean up cluster config
kubectl delete -f api.yaml
kubectl delete -f config-map.yaml
gcloud container clusters delete $CLUSTER_NAME

# clean up cloud resources
terraform destroy
```
