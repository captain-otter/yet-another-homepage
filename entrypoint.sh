#!/bin/sh
# set -e

# Ensure default assets are present.
while true; do echo n; done | cp -Ri /www/default-assets/* /www/assets/ &> /dev/null

# Install default config if no one is available.
yes n | cp -i /www/default-assets/config.yml.dist /www/assets/config.yml &> /dev/null

chown -R $UID:$GID /www/assets
exec su-exec $UID:$GID http-server /www/ -p 8080