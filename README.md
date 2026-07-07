# Hotel Booking Infrastructure

This repository contains the infrastructure and database setup for a hotel booking application. The infrastructure is provisioned using Terraform, while Docker Compose is used for local PostgreSQL testing and database initialization.

## Project Structure

```
.
|-- README.md
|-- backups
|
|-- database
|   |-- indexes.sql
|   |-- schema.sql
|   `-- seed.sql
|-- docker-compose.yml
|-- infra
|   |-- envs
|   |   |-- dev
|   |   |   |-- main.tf
|   |   |   |-- terraform.tfvars
|   |   |   |-- variables.tf
|   |   |   `-- versions.tf
|   |   `-- prod
|   |       |-- main.tf
|   |       |-- outputs.tf
|   |       |-- terraform.tfvars
|   |       |-- variables.tf
|   |       `-- versions.tf
|   `-- modules
|       |-- ecs
|       |   |-- main.tf
|       |   |-- outputs.tf
|       |   `-- variables.tf
|       |-- network
|       |   |-- main.tf
|       |   |-- outputs.tf
|       |   `-- variables.tf
|       |-- rds
|       |   |-- main.tf
|       |   |-- outputs.tf
|       |   `-- variables.tf
|       `-- security_groups
|           |-- main.tf
|           |-- outputs.tf
|           `-- variables.tf
`-- scripts
    |-- backup.sh
    `-- restore.sh

12 directories, 29 files
```

## Infrastructure

The Terraform configuration creates:

- VPC
- Public and private subnets
- Internet Gateway
- Route tables and associations
- Security Groups
- Application Load Balancer
- ECS Cluster and Service
- PostgreSQL RDS instance

Separate environments are maintained for **dev** and **prod**.

## Running Terraform

For either environment:

```bash
cd infra/envs/dev
terraform init
terraform validate
terraform plan
```

For production:

```bash
cd infra/envs/prod
terraform init
terraform validate
terraform plan
```

## Local Database

Start PostgreSQL using Docker Compose:

```bash
docker compose up -d
```

Load the database schema:

```bash
docker exec -i postgres-db psql -U postgres < database/schema.sql
```

Insert sample data:

```bash
docker exec -i postgres-db psql -U postgres < database/seed.sql
```

Create indexes:

```bash
docker exec -i postgres-db psql -U postgres < database/indexes.sql
```

## Backup

```bash
bash scripts/backup.sh
```

## Restore

```bash
bash scripts/restore.sh
```

## Notes

- Infrastructure is organized into reusable Terraform modules.
- Separate Terraform configurations are provided for development and production.
- The sample database includes hotel bookings, booking events, and indexes for commonly used queries.
- The restore script is intended to be used against a fresh local PostgreSQL database.
- Sample data includes multiple cities, organizations, booking statuses and booking events.
