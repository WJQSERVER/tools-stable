sqlite3 "/var/www/html/shpress/wp-content/database/.ht.sqlite" <<EOF
UPDATE wp_options SET option_value = 'http://10.10.20.44:8080' WHERE option_name = 'siteurl';
.quit
EOF