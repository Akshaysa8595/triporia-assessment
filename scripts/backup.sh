#!/bin/bash

mkdir -p backups

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="backups/backup_${TIMESTAMP}.sql"

docker exec postgres-db pg_dump -U postgres postgres > "$BACKUP_FILE"

echo "Backup completed: $BACKUP_FILE"