# Use debian:bullseye-slim as the base image for a minimal and compatible environment.
FROM debian:bullseye-slim

# Set the maintainer label
LABEL maintainer="iskoldt-X"

# Update package lists and install necessary packages:
# - nginx: the web server
# - libnginx-mod-http-dav-ext: Nginx module for WebDAV support
# - apache2-utils: provides utility programs such as htpasswd
# - bash: the shell used in the entrypoint script
RUN apt-get update && \
    apt-get install -y nginx libnginx-mod-http-dav-ext apache2-utils bash && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /etc/nginx/sites-enabled/* && \
    usermod -u 3000 www-data

# Copy the WebDAV configuration file.
# This configuration (webdav.conf) will be placed in the Nginx config directory.
COPY webdav.conf /etc/nginx/conf.d/default.conf

# Copy the entrypoint script to the root directory.
COPY entrypoint.sh /entrypoint.sh

# Expose port 8899 for HTTP traffic.
EXPOSE 8899

# Declare a volume for persistent data storage.
VOLUME /data

# Define the container's entrypoint.
# This script starts Nginx and handles any initialization tasks.
ENTRYPOINT ["bash", "/entrypoint.sh"]
