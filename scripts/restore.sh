#!/bin/bash

LATEST_BACKUP=$(ls -t backups/backup_*.sql | head -n 1)

cat "$LATEST_BACKUP" | docker exec -i postgres-db psql -U postgres postgres

echo "Restore completed from: $LATEST_BACKUP"