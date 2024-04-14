#!/bin/bash
#fork by https://www.nodeseek.com/post-76866-1
sudo mkdir -p /var/log/journal && sudo systemctl restart systemd-journald && sudo journalctl --flush