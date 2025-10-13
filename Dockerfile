# Use Nginx as base image
FROM nginx:alpine

# Copy prebuilt React app
COPY dist/ /usr/share/nginx/html

# Copy nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80 inside container
EXPOSE 80

# Start Nginx in foreground
CMD ["nginx", "-g", "daemon off;"]

