echo "Running Startup"

/usr/sbin/apachectl start

exec "$@"

