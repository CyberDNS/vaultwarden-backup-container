#!/bin/bash

# Check for correct number of arguments
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 user@host vaultwarden-data-path"
    exit 1
fi

SSH_USER_AND_HOST=$1
SSH_REMOTE_PATH=$2

# Define the Docker image name and tag
IMAGE_NAME="vaultwarden-backup"
TAG=$(date +%Y%m%d)
FULL_IMAGE_NAME_DATE="${IMAGE_NAME}:${TAG}"
FULL_IMAGE_NAME_LATEST="${IMAGE_NAME}:latest"

temp_dir=$(mktemp -d tmp.XXXXXX)

scp -r "${SSH_USER_AND_HOST}:${SSH_REMOTE_PATH}/*" "$temp_dir"

echo ${temp_dir}

docker build --build-arg VAULTWARDEN_DATA=${temp_dir}/* -t ${FULL_IMAGE_NAME_LATEST} -t ${FULL_IMAGE_NAME_DATE} .

trap "rm -rf ${temp_dir}" EXIT
