
PARA=false
USER="myzhang"
SSH_OPTION="StrictHostKeyChecking no"

while getopts "f:h:p" optname 
do 
  case "$optname" in 
    "f") 
      SCRIPT=$OPTARG
      ;;
    "h")
      HOSTS=$OPTARG
      ;;
    "p")
      PARA=true
  esac 
done

while read line; do 
  PORT=`echo $line | cut -d " " -f 1`
  HOST=`echo $line | cut -d " " -f 2`

  if $PARA; then
    ssh -p $PORT -o "$SSH_OPTION" $USER@$HOST 'bash -s' < $SCRIPT && echo "$HOST:$PORT done" &
  else
    ssh -p $PORT -o "$SSH_OPTION" $USER@$HOST 'bash -s' < $SCRIPT
    echo "$HOST:$PORT done" 
  fi
done < $HOSTS
 
wait

