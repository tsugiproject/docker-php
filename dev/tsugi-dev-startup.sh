echo "Running dev Startup"

bash /usr/local/bin/tsugi-mysql-startup.sh return

rm -rf /var/www/html/phpMyAdmin
cd /root
curl -O https://files.phpmyadmin.net/phpMyAdmin/4.7.9/phpMyAdmin-4.7.9-all-languages.zip

X=`sha256sum phpMyAdmin-4.7.9-all-languages.zip | awk '{print $1}'`
if [ "$X" == "2fb9f7b31ae7cb71f6398e5da8349fb4f41339386e06a851c4444fc7a938a38a" ]
then
  echo "Sha Match"
  unzip phpMyAdmin-4.7.9-all-languages.zip
  mv phpMyAdmin-4.7.9-all-languages /var/www/html/phpMyAdmin
else
  echo "Sha Mis-Match"
  echo "SHA256 mismatch" >> /tmp/startup-errors
  exec "$@"
  exit
fi


mysql -u root --password=root << EOF
    CREATE DATABASE tsugi DEFAULT CHARACTER SET utf8;
    GRANT ALL ON tsugi.* TO 'ltiuser'@'localhost' IDENTIFIED BY 'ltipassword';
    GRANT ALL ON tsugi.* TO 'ltiuser'@'127.0.0.1' IDENTIFIED BY 'ltipassword';
EOF

cd /var/www/html/
git clone https://github.com/tsugiproject/tsugi.git

mv /root/www/* /var/www/html
mv /var/www/html/config.php /var/www/html/tsugi

# Seed with a few tools
cd /var/www/html/tsugi/mod
git clone https://github.com/tsugitools/youtube
git clone https://github.com/tsugitools/attend
git clone https://github.com/tsugitools/cats

# Create the tables
cd /var/www/html/tsugi/admin
php upgrade.php

# Make git work from the browser
cp /usr/bin/git /usr/local/bin/gitx
chown www-data:www-data /usr/local/bin/gitx
chmod a+s /usr/local/bin/gitx
chown -R www-data:www-data /var/www/html/tsugi

echo ""
if [ "$@" == "return" ] ; then
  echo "Tsugi Dev Returning..."
  exit
fi

# https://stackoverflow.com/questions/2935183/bash-infinite-sleep-infinite-blocking
if [ -n "$WAIT_FOREVER" ] ; then
  echo "Tsugi Dev Sleeping forever..."
  while :; do sleep 2073600; done
fi

echo "Tsugi Dev Executing " $@
exec "$@"
echo "Tsugi Dev Dropping to shell.." $@
exec bash
