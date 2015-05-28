
WORK_DIR=/public
CA_RELEASE=apache-cassandra-1.2.6

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

USER="LAB_USER"

while read line; do 
  PORT=`echo $line | cut -d " " -f 1`
  HOST=`echo $line | cut -d " " -f 2`
  HOST_SHORT=`echo $HOST | cut -d "." -f 1`

  SRC_PREFIX=$WORK_DIR/$HOST_SHORT/$CA_RELEASE/

  scp -P $PORT -r \
      $USER@$HOST:$SRC_PREFIX/$SRC \
      ./${HOST_SHORT}.out \
      && echo "$HOST done" 

done < $HOSTS

