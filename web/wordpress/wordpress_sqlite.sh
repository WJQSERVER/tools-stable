#!/bin/bash

source "repo_url.conf"

ROOT=$(pwd)

apt install php php-cgi php-fpm php-curl php-gd php-mbstring php-xml php-sqlite3 sqlite3 php-mysqli unzip sed -y
wget -q https://cn.wordpress.org/latest-zh_CN.zip
unzip -qq latest-zh_CN.zip
mv wordpress/* .
rm -rf latest-zh_CN.zip
rm -rf wordpress
wget ${repo_url}web/wordpress/wp-config.php

# 下载完整SQLite数据库
# 默认账号admin 默认密码pass
mkdir -p $ROOT/wp-content/database
cd $ROOT/wp-content/database
wget ${repo_url}web/wordpress/db.sqlite
mv db.sqlite .ht.sqlite

#下载官方插件
cd $ROOT/wp-content
mkdir -p mu-plugins
cd mu-plugins
wget https://downloads.wordpress.org/plugin/sqlite-database-integration.zip
unzip -qq sqlite-database-integration.zip
rm -rf sqlite-database-integration.zip

PLUGIN_DIR="$ROOT/wp-content/mu-plugins/sqlite-database-integration"

cp $PLUGIN_DIR/db.copy $ROOT/wp-content/db.php
sed -i "s#{SQLITE_IMPLEMENTATION_FOLDER_PATH}#$PLUGIN_DIR#" $ROOT/wp-content/db.php
sed -i 's#{SQLITE_PLUGIN}#sqlite-database-integration/load.php#' $ROOT/wp-content/db.php

sqlite3 "$ROOT/wp-content/database/.ht.sqlite" <<EOF
UPDATE wp_options SET option_value = 'http://example.com' WHERE option_name = 'siteurl';
.quit
EOF

sqlite3 "$ROOT/wp-content/database/.ht.sqlite" <<EOF
UPDATE wp_options SET option_value = 'http://example.com' WHERE option_name = 'home';
.quit
EOF