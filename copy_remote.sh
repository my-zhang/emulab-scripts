
# cp src to all the hosts, with the target /public/`hostname -s`

WORK_DIR=/public

while getopts "s:h:" optname 
do 
  case "$optname" in 
    "s") 
      SRC=$OPTARG
      ;;
    "h")
      HOSTS=$OPTARG
  esac 
done

USER="EMULAB_USER"

while read line; do 
  PORT=`echo $line | cut -d " " -f 1`
  HOST=`echo $line | cut -d " " -f 2`
  HOST_SHORT=`echo $HOST | cut -d "." -f 1`

  scp -P $PORT -l 8292 -r \
      $SRC \
      $USER@$HOST:$WORK_DIR/$HOST_SHORT/ \
      && echo "$HOST done" &

done < $HOSTS

wait

