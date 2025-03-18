# Use the official Node.js image as the base image
FROM node:18

# Install Bun
RUN npm install -g bun

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and bun.lockb files to the working directory
COPY package.json bun.lockb ./

# Install dependencies
RUN bun install

# Copy the rest of the application code to the working directory
COPY . .

# Expose the port that your app runs on
EXPOSE 5173

# Command to run the development server
CMD ["bun", "run", "dev"]
