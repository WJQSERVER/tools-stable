#!/bin/bash

# 检查是否以root权限运行脚本
if [[ $EUID -ne 0 ]]; then
    echo "请以root权限运行该脚本。"
    exit 1
fi

# 安装Syncthing
apt install syncthing

# 修改Syncthing地址
PUBLIC_IP=0.0.0.0
PORT=8384

# 找到Syncthing的配置文件路径
CONFIG_FILE=$(find /home/*/.config/syncthing/config.xml)

# 修改地址为公网IP和指定端口
sed -i "s|<address>.*</address>|<address>$PUBLIC_IP:$PORT</address>|" $CONFIG_FILE

cat <<EOF > /etc/systemd/system/syncthing.service
[Unit]
Description=Syncthing shell
After=network.target

[Service]
ExecStart=/root/data/syncthing.sh
Restart=always
User=root

[Install]
WantedBy=multi-user.target
EOF

# 启动Syncthing服务
systemctl daemon-reload
systemctl enable syncthing
systemctl start syncthing

#回到root目录
cd /root

# 导入配置文件
source "repo_url.conf"

#等待1s
sleep 3

#返回菜单/退出脚本
read -p "是否返回菜单?: [Y/n]" choice

if [[ "$choice" == "" || "$choice" == "Y" || "$choice" == "y" ]]; then
    wget -O program-menu.sh ${repo_url}program/program-menu.sh && chmod +x program-menu.sh && ./program-menu.sh
else
    echo "脚本结束"
fi