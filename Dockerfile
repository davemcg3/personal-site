# Use the official Nginx image from the Docker Hub
FROM nginx:alpine

# Copy your site content to the default Nginx public directory
COPY site /usr/share/nginx/html

# Change the ownership of the files to the Nginx user
RUN chown -R nginx:nginx /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
