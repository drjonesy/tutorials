# Strapi and Postgres in Docker

### Purpose

I created this repo to provide others with a quick way to spin up containers for **Strapi v5** or whatever the latest version is and to instead ue **Postgres** as the database. This setup also utilizes **OmniDB** to access and manage Postgres if you want. At the time of creating this, Strapi version 5 was not available as a plug-in-play container on `hub.docker.com`.

> **Target Platform:** Mac Mini M1

## Create the files in order

Make sure you download the files before doing anything else. You will need to have the **.env** values set ebfore running any command. Make sure you've downloaded all four files.

### Initial File Structure

```sh
# Create a directory: name it what you want
mkdir strapi_postgres
```

Download the file and setup the structure. Where strapi_postgres is the root directory.

```sh
|__ strapi_postgres
    |__ .env
    |__ create_strapi.sh
    |__ Dockerfile
    |__ docker-compose.yml
```

Define the **.env** values. You must have both the values for Strapi and Postgres. Yes it's redundant but it's required.

### 1) 📋 `.env` (sample)

```sh
# strapi
DATABASE_CLIENT=postgres
DATABASE_HOST=postgres
DATABASE_NAME=strapi_postgres
DATABASE_PORT=5432
DATABASE_USERNAME=pgAdmin
DATABASE_PASSWORD=pgPass1234

# postgres | specific keywords
POSTGRES_DB=strapi_postgres
POSTGRES_USER=pgAdmin
POSTGRES_PASSWORD=pgPass1234
```

### 2) 🖥️ `create_strapi.sh`

Before running this script you will need to execute the terminal command:

```sh
chmod +x create_strapi.sh
```

This will allow you to run the script using the command:

```sh
./create_strapi.sh
```

This script will create the folder: `strapi` and nest another folder `app` inside. I did this in case you want to create a separate file inside the strapi directory. The script will then install the latest version of Strapi in the `app` folder and set database values defined in the `.env` file.

### 3) 🐳 Docker

Make sure `docker` is running and you've downloaded the files: `Dockerfile` and `docker-compose.yml`

In your terminal run the command:

```sh
docker compose up -d

# You might encounter a write permission error like. Just go ahead and run this if needed.
sudo chown -R 501:20 "/Users/admin/.npm"
```

Running `docker compose up -d` should generate a new folder/directory `/postgres/app` with the Postgres files installed in the `app` folder.

It will also create a container for Postgres and OmniDB. Then create a custom container using the `./strapi/app/` files.

> [!WARNING]
> DO NOT **DELETE** - The postgres or strapi directories because they are tied to your Docker application when you need to restart or update some functionality !!!
