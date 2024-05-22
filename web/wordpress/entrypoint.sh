#!/bin/bash

siteurl=$siteurl

sqlite3 "/var/www/html/wordpress/wp-content/database/.ht.sqlite" <<EOF
UPDATE wp_options SET option_value = '$siteurl' WHERE option_name = 'siteurl';
UPDATE wp_options SET option_value = '$siteurl' WHERE option_name = 'home';
.quit
EOF

cat > /data/caddy/config/wordpress <<EOF
$siteurl {
	root * /var/www/html/wordpress
    php_fastcgi unix//run/php/php8.2-fpm.sock {
        import header_realip
    }
    file_server
    import log
    import error_page  
    import encode
}
EOF