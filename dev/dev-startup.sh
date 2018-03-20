echo "Running Startup"

bash /usr/local/bin/tsugi-mysql-startup.sh

exec "$@"

