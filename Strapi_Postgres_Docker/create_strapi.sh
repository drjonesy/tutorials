#!/bin/bash

# First set permissions
# chmod +x create_strapi.sh
# Then run: ./create_strapi.sh

# This script creates a Strapi v5 project using npx and reads
# database credentials from a .env file to pass as command-line arguments.

# Exit immediately if a command exits with a non-zero status.
set -e
# Treat unset variables as an error when substituting.
set -u
# Pipefail: If any command in a pipeline fails, the whole pipeline fails.
set -o pipefail

# Define the path to the .env file
ENV_FILE="./.env"

# Check if the .env file exists
if [ ! -f "$ENV_FILE" ]; then
  echo "Error: .env file not found at $ENV_FILE"
  echo "Please create a .env file with your database credentials."
  exit 1
fi

echo "Loading environment variables from $ENV_FILE..."

# Read the required database variables from the .env file
# We use grep and cut to extract the values, handling potential whitespace
DB_CLIENT=$(grep -E "^DATABASE_CLIENT=" "$ENV_FILE" | cut -d '=' -f 2- | tr -d '"' | tr -d "'")
DB_HOST=$(grep -E "^DATABASE_HOST=" "$ENV_FILE" | cut -d '=' -f 2- | tr -d '"' | tr -d "'")
DB_PORT=$(grep -E "^DATABASE_PORT=" "$ENV_FILE" | cut -d '=' -f 2- | tr -d '"' | tr -d "'")
DB_NAME=$(grep -E "^DATABASE_NAME=" "$ENV_FILE" | cut -d '=' -f 2- | tr -d '"' | tr -d "'")
DB_USERNAME=$(grep -E "^DATABASE_USERNAME=" "$ENV_FILE" | cut -d '=' -f 2- | tr -d '"' | tr -d "'")
DB_PASSWORD=$(grep -E "^DATABASE_PASSWORD=" "$ENV_FILE" | cut -d '=' -f 2- | tr -d '"' | tr -d "'")

# Check if all required variables were found
if [ -z "$DB_CLIENT" ] || [ -z "$DB_HOST" ] || [ -z "$DB_PORT" ] || [ -z "$DB_NAME" ] || [ -z "$DB_USERNAME" ] || [ -z "$DB_PASSWORD" ]; then
  echo "Error: One or more required database variables are missing or empty in the .env file."
  echo "Required variables: DATABASE_CLIENT, DATABASE_HOST, DATABASE_PORT, DATABASE_NAME, DATABASE_USERNAME, DATABASE_PASSWORD"
  exit 1
fi

echo "Database credentials loaded."
echo "Creating Strapi project..."

# Define the project directory (current directory)
PROJECT_DIR="./strapi/app"

# Construct and execute the npx create-strapi command
# We pass the database credentials as command-line arguments
npx create-strapi@latest "$PROJECT_DIR" \
  --no-run \
  --typescript \
  --git-init \
  --no-example \
  --skip-cloud \
  --install \
  --dbclient "$DB_CLIENT" \
  --dbhost "$DB_HOST" \
  --dbport "$DB_PORT" \
  --dbname "$DB_NAME" \
  --dbusername "$DB_USERNAME" \
  --dbpassword "$DB_PASSWORD"

echo "Strapi project creation command executed."
echo "Please check the output above for any errors during project creation."
echo "If successful, you can now proceed with the Dockerfile and docker-compose.yml setup."

exit 0
