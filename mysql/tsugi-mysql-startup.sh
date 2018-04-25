echo "Running MySQL Startup"

bash /usr/local/bin/tsugi-base-startup.sh return

# Mysql
# sed -i -e 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mysql.conf.d/mysqld.cnf

# Make it so mysql can touch the local file system
rm /var/log/mysql/error.log
chmod -R ug+rw /var/lib/mysql
chown -R mysql:mysql /var/lib/mysql

# https://stackoverflow.com/questions/9083408/fatal-error-cant-open-and-lock-privilege-tables-table-mysql-host-doesnt-ex
# This happens if /var/lib/mysql is a fresh mount
if [ ! -f /var/lib/mysql/mysql ]; then
    echo Re-initializing the mysql database
    mysql_install_db --user=mysql --ldata=/var/lib/mysql
fi
service mysql start
if [ -z "$MYSQL_ROOT_PASSWORD" ]; then
    /usr/bin/mysqladmin -u root password 'root'
else
    /usr/bin/mysqladmin -u root password '$MYSQL_ROOT_PASSWORD'
fi  

echo ""
if [ "$@" == "return" ] ; then
  echo "Tsugi Base Returning..."
  exit
fi

exec bash /usr/local/bin/monitor-apache.sh

# Should never happen
# https://stackoverflow.com/questions/2935183/bash-infinite-sleep-infinite-blocking
echo "Tsugi Base Sleeping forever..."
while :; do sleep 2073600; done

