#!/usr/bin/env bash
set -e

# Fetch this instance's current public IP and public DNS hostname dynamically
# (both can change after a reboot, since no Elastic IP is attached, and users
# may browse via either one).
TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
PUBLIC_IP=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/public-ipv4)
PUBLIC_DNS=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/public-hostname)

# Replace the whole ALLOWED_HOSTS line (idempotent: works on every deployment,
# not just the first one where it's still an empty list).
sed -i "s/^ALLOWED_HOSTS = .*/ALLOWED_HOSTS = [\"$PUBLIC_IP\", \"$PUBLIC_DNS\"]/" /home/ec2-user/project_devops/agency/settings.py

source /home/ec2-user/env/bin/activate
cd /home/ec2-user/project_devops
python manage.py migrate
python manage.py makemigrations
python manage.py collectstatic --noinput

sudo systemctl restart gunicorn
sudo systemctl restart nginx
