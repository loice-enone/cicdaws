#!/usr/bin/env bash
set -e

# Use python3.11 explicitly: Django 5.1 requires Python 3.10+
rm -rf /home/ec2-user/env
python3.11 -m venv /home/ec2-user/env
source /home/ec2-user/env/bin/activate
pip install --upgrade pip
pip install -r /home/ec2-user/project_devops/requirements.txt
