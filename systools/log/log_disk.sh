#!/bin/bash
#fork by https://www.nodeseek.com/post-76866-1
grep -q "^Storage=" /etc/systemd/journald.conf && sudo sed -i 's/^Storage=.*/Storage=persistent/' /etc/systemd/journald.conf || echo "Storage=persistent" | sudo tee -a /etc/systemd/journald.conf > /dev/null && sudo systemctl restart systemd-journald && sudo journalctl --flush