#!/usr/bin/env bash
chown -R webapp:webapp /var/app/current
cd /var/app/current
chown -R webapp:webapp /var/app/current/storage/framework/sessions
chown -R webapp:webapp /var/app/current/storage/logs

composer install --no-scripts --no-dev --no-interaction
composer dump-autoload --no-scripts --optimize --no-interaction

chmod -R 755 /var/app/current/bootstrap/cache
chmod -R 755 /var/app/current/storage
if [ ! -d "/var/app/current/storage/logs" ]; then
  mkdir -p /var/app/current/storage/logs
fi
if [ ! -d "/var/app/current/storage/framework/sessions" ]; then
  mkdir -p /var/app/current/storage/framework/sessions
fi
chown -R webapp:webapp /var/app/current/storage/logs
chown -R webapp:webapp /var/app/current/storage/framework/sessions
chmod -R 775 /var/app/current/storage/logs
chmod -R 775 /var/app/current/storage/framework/sessions
chown root:root .
npm install --ignore
npm run dev
composer install
php artisan migrate
if [ ! -d "/var/app/current/storage/framework/sessions" ]; then
  mkdir -p /var/app/current/storage/framework/sessions
fi
chown -R webapp:webapp /var/app/current/storage/logs
chown -R webapp:webapp /var/app/current/storage/framework/sessions