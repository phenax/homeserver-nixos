#!/usr/bin/env sh
set -euo pipefail

sudo chown -R bacchus:multimedia /media
sudo chown -R sonarr:multimedia /media/tv
sudo chown -R radarr:multimedia /media/movies
sudo chown -R transmission:multimedia /media/_downloads

