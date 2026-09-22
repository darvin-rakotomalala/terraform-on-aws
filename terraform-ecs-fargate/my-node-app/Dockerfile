# Use an official Node.js Long Term Support (LTS) image based on Alpine Linux
FROM node:20-alpine

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the container
# This step is done separately to leverage Docker's layer caching
COPY package*.json ./

# Install application dependencies
RUN npm install

# Copy the rest of the application source code to the container
COPY . .

# Expose the port your Node.js application listens on
EXPOSE 3000

# Define environment variables (optional, but good practice for development)
ENV NODE_ENV=dev

# Command to run the application when the container starts
CMD ["node", "app.js"]