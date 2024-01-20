#!/bin/bash
# wait-for-mysql.sh

runtime="5 minute"
endtime=$(date -ud "$runtime" +%s)
success=false
i=5
until [ $endtime -le $(date -u +%s) ]; do
  let i+=1
  >&2 echo "wait-for-mysql.sh attempting connection"
  mysqlResponse=$(mysqladmin ping -h"${DB_HOST}" -P"${DB_PORT}" -u"${DB_USERNAME}" -p"${DB_PASSWORD}" --silent --connect-timeout=10)
  if [ ! -z "${mysqlResponse}" ]; then
    success=true
    break
  fi
  if ((i>=5)); then
    i=0
    >&2 echo "wait-for-mysql.sh connection unavailable - sleeping"
  fi
  sleep 1
done

if [ ${success} == true ]; then
  >&2 echo "wait-for-mysql.sh connected successfully - executing command"
  eval "$@"
else
  echo "wait-for-mysql.sh connection unsuccessful:timeout - stopping"
  exit 1;
fi
