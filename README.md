# Vaultwarden Backup Docker Container

This repository contains the necessary files to create a Docker container for backing up Vaultwarden data. Vaultwarden is an open-source project that provides a self-hosted, web-based password management service. This backup solution utilizes Docker to ensure your Vaultwarden data is securely backed up and can be restored with ease.

I developed this repository to address a specific challenge with my self-hosted Vaultwarden setup: it contains the passwords to my backups. Recognizing the risk of losing access to my entire server and thereby to my cloud-stored backups, I sought an easy and reliable method to periodically clone my Vaultwarden data to my laptop. This ensures that, even in the event of server access loss, I retain the ability to decrypt my backups stored in the cloud.

## Repository Contents

- **Dockerfile**: Specifies the Docker container configuration, ensuring Vaultwarden data is properly placed within the container.
- **generate-image.sh**: A script to facilitate the building of the Docker image with the latest Vaultwarden data from a specified remote location.
- **serve.sh**: A script to run the Docker container, making the Vaultwarden backup available.

## Prerequisites

Before you begin, ensure you have the following installed:
- Docker
- Bash
- SCP (for the `generate-image.sh` script)

## Usage

### Building the Docker Image

1. Ensure you have SSH access to the host where your Vaultwarden data is stored.
2. Run the `generate-image.sh` script with the appropriate parameters:

```bash
chmod +x *.sh

./generate-image.sh user@host path/to/vaultwarden/data
```

This script will:

* Securely copy the Vaultwarden data from the specified remote location.
* Build a Docker image containing the Vaultwarden data.
* __Tag__ the image with both the __current date__ and __latest__.

### Serving the Backup
To serve the backup, simply execute the serve.sh script:

```bash
./serve.sh
```

This will:

* Stop any previously running container named vaultwarden-backup.
* Remove any previous container with the same name.
* Run a new container, exposing the service on port __8080__.

The you can access you vault locally on http://localhost:8080