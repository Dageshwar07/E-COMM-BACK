# Stage 1: Build Stage
FROM node:18-alpine AS build

# Set working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the entire project files to the container
COPY . .

# Build your application (if needed, add a build step here for things like TypeScript compilation)
# RUN npm run build

# Stage 2: Production Stage
FROM node:18-alpine

# Set the working directory in the container
WORKDIR /app

# Copy only the necessary files from the build stage
COPY --from=build /app /app

# Install only production dependencies
RUN npm install --only=production

# Expose the port that the app runs on
EXPOSE 4000

# Set environment variables (optional)
ENV NODE_ENV=production
ENV PORT=4000
ENV BASE_URL=http://localhost:4000

# Start the application
CMD ["npm", "start"]
