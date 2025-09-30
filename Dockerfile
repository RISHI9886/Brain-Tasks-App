# Dockerfile
FROM nginx:alpine
FROM 275057777725.dkr.ecr.us-east-1.amazonaws.com/nginx:alpine

# Copy the compiled React app to Nginx html folder
COPY dist/ /usr/share/nginx/html

# Expose port 3000 instead of 80
EXPOSE 3000

# Start Nginx with custom port 3000
CMD ["nginx", "-g", "daemon off;", "-c", "/etc/nginx/nginx.conf"]

