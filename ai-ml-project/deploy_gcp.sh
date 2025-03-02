#!/usr/bin/env bash
set -e

PROJECT_ID="your-gcp-project-id"
REGION="us-central1"
SERVICE_NAME="astronomy-ml-service"
IMAGE_NAME="gcr.io/${PROJECT_ID}/astronomy-ml-project:latest"

# Build and push Docker image to Google Container Registry
docker build -t "$IMAGE_NAME" .
docker push "$IMAGE_NAME"

# Example: Deploy on Google Compute Engine
echo "Creating VM on GCE..."
gcloud compute instances create-with-container "$SERVICE_NAME" \
  --container-image="$IMAGE_NAME" \
  --project="$PROJECT_ID" \
  --zone="${REGION}-a" \
  --machine-type="n1-standard-4" \
  --scopes=https://www.googleapis.com/auth/cloud-platform

echo "Deployment complete!"
