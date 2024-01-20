#!/bin/bash
# wait-for-file.sh

file="/var/www/html/docker-compose.yml"
if [[ -z $1 ]] || [[ "$1" = "--help" ]] ; then
  echo ;
  echo 'arguments missing'
  echo 'wait-for-file.sh <<command>>'
  echo "-f file to wait for (default: ${file} )"
  exit 1;
fi
while getopts ":f:" opt; do
  case $opt in
    f)
      file=$OPTARG;
      shift $((OPTIND-1))
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

runtime="5 minute"
endtime=$(date -ud "$runtime" +%s)
i=5
until [ $endtime -le $(date -u +%s) ] || [ -f "${file}" ] ; do
  let i+=1
  if ((i>=5)); then
    i=0
    >&2 echo "wait-for-file.sh did not find ${file} - sleeping"
  fi
  sleep 1
done

if [ -f "${file}" ]; then
  >&2 echo "wait-for-file.sh found ${file} - executing command"
  eval "$@"
else
  echo 'wait-for-file.sh timeout'
  exit 1;
fi
