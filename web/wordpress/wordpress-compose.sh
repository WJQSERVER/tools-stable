apt update
apt install -y libmariadb-dev-compat libmariadb-dev libzip-dev libmagickwand-dev imagemagick
docker-php-ext-install mysqli pdo_mysql zip exif gd intl bcmath opcache curl mbstring xml sqlite3