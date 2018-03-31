echo "Running Base Startup"

sed -i.bak 's/AllowOverride None/AllowOverride All/g' /etc/apache2/apache2.conf

/usr/sbin/apachectl start

echo "Environment variables:"
env

echo ""
if [ "$@" == "return" ] ; then
  echo "Tsugi Base Returning..."
  exit
fi

# https://stackoverflow.com/questions/2935183/bash-infinite-sleep-infinite-blocking
if [ -n "$WAIT_FOREVER" ] ; then
  echo "Tsugi Base Sleeping forever..."
  while :; do sleep 2073600; done
fi

echo "Tsugi Base Executing " $@
exec "$@"
echo "Tsugi Base Dropping to shell.." $@
exec bash


