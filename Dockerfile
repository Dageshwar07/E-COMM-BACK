# Use official Node.js image
FROM node:18-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Copy .env file (for environment variables)
COPY .env .env
# Install dependencies
RUN npm install

# Install PM2 globally
RUN npm install -g pm2

# Copy the entire project
COPY . .

# Expose the port
EXPOSE 4000

# Start the app with PM2
CMD ["pm2-runtime", "start", "server.js"]
