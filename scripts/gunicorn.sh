#!/usr/bin/env bash
set -e

sudo cp /home/ec2-user/project_devops/gunicorn/gunicorn.socket /etc/systemd/system/gunicorn.socket
sudo cp /home/ec2-user/project_devops/gunicorn/gunicorn.service /etc/systemd/system/gunicorn.service

sudo systemctl daemon-reload
sudo systemctl start gunicorn.socket
sudo systemctl enable gunicorn.socket
