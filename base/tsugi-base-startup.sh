echo "Running Startup"

sed -i.bak 's/AllowOverride None/AllowOverride All/g' /etc/apache2/apache2.conf

/usr/sbin/apachectl start

exec "$@"

