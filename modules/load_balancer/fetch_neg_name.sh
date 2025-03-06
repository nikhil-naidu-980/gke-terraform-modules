
#!/bin/bash
# Use environment variables passed from Terraform
SERVICE_NAME="$1"  # nginx_service_name
NAMESPACE="$2"     # nginx_namespace
ZONE="us-west1-a"  # Hardcoded for now; could be a variable

NEG_NAME=$(gcloud compute network-endpoint-groups list \
  --filter="name:k8s1 AND ${SERVICE_NAME}" \
  --zones="${ZONE}" \
  --format="value(name)" | head -n 1)

if [ -z "$NEG_NAME" ]; then
  echo "{\"neg_name\": \"ERROR: NEG not found for ${NAMESPACE}/${SERVICE_NAME}\"}" >&2
  exit 1
else
  echo "{\"neg_name\": \"$NEG_NAME\"}"
fi