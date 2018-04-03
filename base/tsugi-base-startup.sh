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

exec bash /usr/local/bin/monitor-apache.sh

# Should never happen
# https://stackoverflow.com/questions/2935183/bash-infinite-sleep-infinite-blocking
echo "Tsugi Base Sleeping forever..."
while :; do sleep 2073600; done


