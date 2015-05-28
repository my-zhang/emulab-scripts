#!/usr/bin/env bash 

# create keyspace, on seed node. 

WORK_DIR=/public/`hostname -s`/
CA_RELEASE=apache-cassandra-1.2.6

cd $WORK_DIR/$CA_RELEASE

for i in `seq 1 100`
do
cat <<EOF | bin/cassandra-cli
  create keyspace KS$i;
EOF
done
