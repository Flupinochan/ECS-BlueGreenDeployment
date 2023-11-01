FROM wordpress:latest
CMD /bin/bash -c "echo 'Version: ' $(date) > /var/www/html/version.txt && curl -s $ECS_CONTAINER_METADATA_URI_V4/task >> /var/www/html/version.txt && docker-entrypoint.sh apache2-foreground"
# CMD ["apache2-foreground"]