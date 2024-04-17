#! /bin/bash

#导入变量
source "repo_url.conf"

#安装环境
apt install php-cgi php-fpm php-curl php-gd php-mbstring php-xml php-sqlite3 sqlite3 -y

#安装Caddy2
# 创建目录
mkdir -p /root/data/caddy
cd /root/data/caddy

#下载
wget https://raw.githubusercontent.com/WJQSERVER/tools-stable/main/program/caddy/caddy.tar.gz

#解压
tar -xzvf caddy.tar.gz
rm caddy.tar.gz

#赋权
chmod +x /root/data/caddy/caddy
chown root:root /root/data/caddy/caddy

# 创建服务文件
cat <<EOF > /etc/systemd/system/caddy.service
[Unit]
Description=Caddy
Documentation=https://caddyserver.com/docs/
After=network.target network-online.target
Requires=network-online.target

[Service]
Type=notify
User=root
Group=root
ExecStart=/root/data/caddy/caddy run --environ --config /root/data/caddy/Caddyfile
ExecReload=/root/data/caddy/caddy reload --config /root/data/caddy/Caddyfile --force
WorkingDirectory=/root/data/caddy
TimeoutStopSec=5s
LimitNOFILE=1048576
PrivateTmp=true
ProtectSystem=full
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE

[Install]
WantedBy=multi-user.target
EOF

#创建hello world
mkdir -p /root/data/caddy/page
cat <<EOF > /root/data/caddy/page/index.html
<html>
 <head>
 </head>
 <body>
   <h1> Hello World </h1>
   <h2> Hello World </h2>
   <h3> Hello World </h3>
   <h4> Hello World </h4>
   <h5> Hello World </h5>
   <h6> Hello World </h6>
 </body>
</html>

EOF

#创建caddyfile
cat <<EOF > /root/data/caddy/Caddyfile
{
    debug
    http_port 80
    https_port 443
    order cache before rewrite
    cache    
}

:80 {
	root * /root/data/caddy/page
	try_files {path}/index.html
    file_server
    cache {
         allowed_http_verbs GET
         stale 100s
         ttl 200s
    }
    handle_errors {
	    rewrite * /{err.status_code}
	    reverse_proxy https://http.cat {
		    header_up Host {upstream_hostport}
	    }
    }     
    encode gzip zstd br
}
EOF

#赋权
chown root:root /root/data/caddy/Caddyfile

# 开启Caddy
systemctl daemon-reload
systemctl enable caddy
systemctl start caddy
systemctl status caddy

mkdir -p /root/www/site
cd /root/www/site
wget https://cn.wordpress.org/latest-zh_CN.zip
apt install unzip
unzip latest-zh_CN.zip
rm -rf latest-zh_CN.zip #删除压缩包
chown www-data:www-data -R /root/www/site/wordpress
chmod 755 -R /root/www/site/wordpress
cd /root/www/site/wordpress/wp-content
wget https://github.com/aaemnnosttv/wp-sqlite-db/blob/master/src/db.php
chmod 777 -R /root/www/site/wordpress/wp-content/db.php