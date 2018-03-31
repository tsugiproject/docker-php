echo "Running Base Startup"

sed -i.bak 's/AllowOverride None/AllowOverride All/g' /etc/apache2/apache2.conf

/usr/sbin/apachectl start

if [ "$@" == "return" ] ; then
  echo "Tsugi Base Returning..."
else
  echo "Tsugi Base Executing " $@
  exec "$@"
  echo "Tsugi Base Dropping to shell.." $@
  exec bash
fi


