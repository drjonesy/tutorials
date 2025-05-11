# Use a Node.js base image
FROM node:20-alpine

# Set the working directory in the container
# This is where the Strapi application will live inside the container
WORKDIR /app

# Copy package.json and package-lock.json (or yarn.lock) from the './strapi/app' subdirectory
# The source path './strapi/app/' is relative to the build context (which is the root './')
COPY ./strapi/app/package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code from the './strapi/app' subdirectory
# The source path './strapi/app/' is relative to the build context (which is the root './')
COPY ./strapi/app/ . .

# Build the admin panel (optional for dev, recommended for prod)
# RUN npm run build

# Expose the port Strapi runs on
EXPOSE 1337

# Command to run the application
# Strapi reads DATABASE_* environment variables for connection
CMD ["npm", "run", "develop"]
