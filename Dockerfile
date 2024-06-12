# Stage 1: Build the React app
FROM node:14 AS build

# Set the working directory
WORKDIR /usr/src/singh_harkamal_site

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the application
RUN npm run build

# Stage 2: Serve the React app using nginx
FROM nginx:alpine

# Copy the built React app from the previous stage to nginx's web directory
COPY --from=build /usr/src/singh_harkamal_site/build /usr/share/nginx/html

# Expose the port the app will run on
EXPOSE 80

# Start nginx server
CMD ["nginx", "-g", "daemon on;"]
