echo "Running MySQL Startup"

bash /usr/local/bin/tsugi-base-startup.sh return

# Mysql
# sed -i -e 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mysql.conf.d/mysqld.cnf

# Make it so mysql can touch the local file system
rm /var/log/mysql/error.log
chmod -R ug+rw /var/lib/mysql
chown -R mysql:mysql /var/lib/mysql
service mysql start

echo ""
if [ "$@" == "return" ] ; then
  echo "Tsugi MySQL Returning..."
  exit
fi

# https://stackoverflow.com/questions/2935183/bash-infinite-sleep-infinite-blocking
if [ -n "$WAIT_FOREVER" ] ; then
  echo "Tsugi MySQL Sleeping forever..."
  while :; do sleep 2073600; done
fi

echo "Tsugi MySQL Executing " $@
exec "$@"
echo "Tsugi MySQL Dropping to shell.." $@
exec bash
