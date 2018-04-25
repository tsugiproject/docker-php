echo "Running Base Startup"

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


