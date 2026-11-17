# Stage 1: build the app with Node
FROM node:26-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Stage 2: serve the built files with nginx
FROM nginx:alpine
# Vite builds to dist/ (Create React App: build/)
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80

# Build and run instructions:
# 
# STEP 1: Build the Docker image
#   docker build -t my-react-demo-app .
#   (Note: The '.' specifies the build context as the current directory - it's required)
#
# STEP 2: Run the container
#   docker run -p 9000:80 my-react-demo-app:latest
#   (Maps port 9000 on your host to port 80 in the container)
