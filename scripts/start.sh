#!/usr/bin/env bash 
CA_RELEASE=apache-cassandra-1.2.6

cd /public/`hostname -s`/$CA_RELEASE && ./bin/cassandra

