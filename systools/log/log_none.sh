#!/bin/bash
#fork by https://www.nodeseek.com/post-76866-1
grep -q "^Storage=" /etc/systemd/journald.conf && sudo sed -i 's/^Storage=.*/Storage=none/' /etc/systemd/journald.conf || echo "Storage=none" | sudo tee -a /etc/systemd/journald.conf > /dev/null && sudo systemctl restart systemd-journald