# Use the official Nginx image from the Docker Hub
FROM nginx:alpine

# Install required packages
RUN apk add --no-cache inotify-tools shadow spawn-fcgi fcgi

# Create nginx user with same UID as WSL2 user
RUN usermod -u 1000 nginx && \
    groupmod -g 1000 nginx

#production
# Copy your site content to the default Nginx public directory
# COPY site /usr/share/nginx/html

# Change the ownership of the files to the Nginx user
# RUN chown -R nginx:nginx /usr/share/nginx/html

#development

RUN mkdir -p /usr/share/nginx/html && \
    chown -R nginx:nginx /usr/share/nginx/html && \
    chmod -R 775 /usr/share/nginx/html

# Copy nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf
COPY live-reload.sh /usr/local/bin/live-reload-server
RUN chmod +x /usr/local/bin/live-reload-server

# Add a script to watch for changes and update permissions
COPY <<'EOF' /watch-and-update.sh
#!/bin/sh
RELOAD_FILE=/tmp/live-reload
touch $RELOAD_FILE
while true; do
  inotifywait -r -e modify,create,delete,move /usr/share/nginx/html
  chown -R nginx:nginx /usr/share/nginx/html
  chmod -R 775 /usr/share/nginx/html
  find /usr/share/nginx/html -type d -exec chmod 775 {} \;
  touch $RELOAD_FILE
done
EOF

RUN chmod +x /watch-and-update.sh

# # Expose port 80
EXPOSE 80

# Use a shell script to start both nginx and the watcher
COPY <<'EOF' /docker-entrypoint.sh
#!/bin/sh
/usr/local/bin/live-reload-server &
/watch-and-update.sh &
nginx -g 'daemon off;'
EOF

RUN chmod +x /docker-entrypoint.sh

# # Start Nginx server
# CMD ["nginx", "-g", "daemon off;"]

CMD ["/docker-entrypoint.sh"]