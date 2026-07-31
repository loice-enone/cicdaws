#!/usr/bin/env bash
set -e

sudo systemctl daemon-reload

# Amazon Linux's nginx uses /etc/nginx/conf.d/*.conf (no sites-available/sites-enabled like on Ubuntu/Debian)
sudo cp /home/ec2-user/project_devops/nginx/nginx.conf /etc/nginx/conf.d/agency.conf

sudo nginx -t
sudo systemctl restart nginx
