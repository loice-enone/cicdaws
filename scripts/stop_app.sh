#!/usr/bin/env bash
# ApplicationStop hook: stop the services before the new revision is installed.
# "|| true" prevents a fresh deployment (where the service doesn't exist yet) from failing.
sudo systemctl stop gunicorn || true
