#!/usr/bin/env bash
set -e

# CodeDeploy copies files as root; make sure ec2-user owns the whole
# project directory so migrations, collectstatic, sockets, etc. work.
sudo chown -R ec2-user:ec2-user /home/ec2-user/project_devops

# Works on both Amazon Linux 2 (yum) and Amazon Linux 2023 (dnf)
PKG=dnf
command -v dnf >/dev/null 2>&1 || PKG=yum

# Django 5.1 requires Python 3.10+; Amazon Linux's default python3 is often 3.9,
# so we install python3.11 explicitly and use it to build the venv.
sudo $PKG install -y python3.11 python3.11-pip
sudo $PKG install -y nginx
sudo systemctl enable nginx
