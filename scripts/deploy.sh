#!/usr/bin/env bash 

WORK_DIR=/public/`hostname -s`

cd $WORK_DIR

CA_RELEASE=apache-cassandra-1.2.6

rm -rf $CA_RELEASE

echo "decompressing ..."
tar xzf $CA_RELEASE-bin.tgz

touch $CA_RELEASE 

sed -i -e "s/listen_address:.*/listen_address: `hostname -s`/g" $CA_RELEASE/conf/cassandra.yaml

