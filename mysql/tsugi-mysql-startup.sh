echo "Running Startup"

bash /usr/local/bin/tsugi-base-startup.sh echo base done

# Mysql
# sed -i -e 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mysql.conf.d/mysqld.cnf

# Make it so mysql can touch the local file system
rm /var/log/mysql/error.log
chmod -R ug+rw /var/lib/mysql
chown -R mysql:mysql /var/lib/mysql
service mysql start

exec "$@"

