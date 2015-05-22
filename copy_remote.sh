
WORK_DIR=/public

ZIP=false

while getopts "s:h:z" optname 
do 
  case "$optname" in 
    "s") 
      SRC=$OPTARG
      ;;
    "h")
      HOSTS=$OPTARG
      ;;
    "z")
      ZIP=true
  esac 
done

USER="myzhang"

while read line; do 
  PORT=`echo $line | cut -d " " -f 1`
  HOST=`echo $line | cut -d " " -f 2`
  HOST_SHORT=`echo $HOST | cut -d "." -f 1`

  if $ZIP ;then 
    tar cf - $SRC | ssh $USER@$HOST 'cd /public && tar xf -'
  else
    scp -P $PORT -l 8292 -r $SRC $USER@$HOST:$WORK_DIR/$HOST_SHORT/ && echo "$HOST done" &
  fi
done < $HOSTS

wait

