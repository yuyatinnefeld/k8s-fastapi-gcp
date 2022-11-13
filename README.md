# kubernetes simple fastapi


## How to Run 🐳

Template for a Python FastAPI with Dockerfile and configuration for Kubernetes

## Development setup

To run (in isolation), either:

Run from active Python environment using `uvicorn`:

    pip install -r requirements.txt
    uvicorn service.main:app --host 0.0.0.0 --port 8080 --reload

Or build and run the Docker container:
    export VERSION="1.0.1"

    docker build -t yuya_simple_fastapi:$VERSION .
    docker run -p 8080:8080 --name k-fastapi yuya_simple_fastapi:$VERSION

Navigate to http://localhost:8080/docs to test the API.

## Push the container image to Docker Hub

If desired, push the container to Docker Hub yourself, and change all references to the image accordingly.

    docker tag yuya_simple_fastapi:$VERSION yuyatinnefeld/yuya_simple_fastapi:$VERSION
    docker push yuyatinnefeld/yuya_simple_fastapi:$VERSION
    docker run -p 8080:8080 --name k-fastapi yuyatinnefeld/yuya_simple_fastapi:$VERSION

You may also need to make the image public as well.

## Google Cloud GKE initial setup (Cloud Shell)

    export PROJECT_ID="yuyatinnefeld-dev"
    export CLUSTER_NAME="fastapi-node"
    export VPC_NETWORK="vpc-mainnet"

    gcloud config set project $PROJECT_ID
    gcloud config set compute/zone europe-west1-b
    
    gcloud container clusters create $CLUSTER_NAME --num-nodes=2 --network $VPC_NETWORK
    gcloud container clusters get-credentials $CLUSTER_NAME

## Kubernetes deployment (Cloud Shell)

    gcloud components install kubectl

    kubectl apply -f api.yaml

If working locally, e.g. using `minikube`, use port forwarding to expose the service:

    kubectl port-forward service/kf-api-svc 8080

    verify the result

    # open GCP webviewer
    # example
    https://8080-cs-e503cce9-67f8-4ec8-a12f-469da33403a1.cs-europe-west1-iuzs.cloudshell.dev/docs



## Teardown

    kubectl delete deployment kf-api
    kubectl delete svc kf-api-svc
    kubectl delete hpa kf-api-hpa

## Google Cloud clean-up

    gcloud container clusters delete $CLUSTER_NAME

