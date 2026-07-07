#!/bin/bash

cat backups/backup.sql | docker exec -i postgres-db psql -U postgres postgres

echo "Restore completed."