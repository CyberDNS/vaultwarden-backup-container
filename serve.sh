#!/bin/bash

docker stop vaultwarden-backup 2> /dev/null
docker rm vaultwarden-backup 2> /dev/null

docker run -p 8080:80 --name vaultwarden-backup vaultwarden-backup