#!/bin/bash

mkdir -p backups

docker exec postgres-db pg_dump -U postgres postgres > backups/backup.sql

echo "Backup completed: backups/backup.sql"