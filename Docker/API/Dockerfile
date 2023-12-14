# Use the official Node.js image as a base image
FROM node:18.18.1-alpine

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install dependencies
RUN npm install
RUN npm install pg-promise ssh2 body-parser express

# Copy the rest of the application code to the container
COPY . .

# Expose the port that your Node.js app will run on
EXPOSE 3001

# Command to run the application
CMD ["node", "app.js"]