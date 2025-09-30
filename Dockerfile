# Dockerfile
FROM nginx:alpine

# Copy the compiled React app to Nginx html folder
COPY dist/ /usr/share/nginx/html

# Expose port 3000 instead of 80
EXPOSE 3000

# Start Nginx with custom port 3000
CMD ["nginx", "-g", "daemon off;", "-c", "/etc/nginx/nginx.conf"]

