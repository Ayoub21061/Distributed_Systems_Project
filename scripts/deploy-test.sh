#!/usr/bin/env bash
set -euo pipefail 
cd "$(dirname "$0")/.."
TAG="${1:?Please provide a tag for the deployment.}"
docker build -t photo-service:"$TAG" ./app
kind load docker-image photo-service:"$TAG" --name photo
(cd k8s/overlays/test && kustomize edit set image photo-service:"$TAG")
kubectl apply -k ./k8s/overlays/test --context kind-photo
kubectl rollout status deployment/photo-service -n test --timeout=120s --context kind-photo