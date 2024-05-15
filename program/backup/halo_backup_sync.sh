#! /bin/bash

cd /root/data/docker_data/halo
docker compose stop
cd /root/data/backup
tar -I zstd -xvf halo_backup.tar.zst -C /root/data/docker_data/halo
cd /root/data/docker_data/halo
docker compose up -d