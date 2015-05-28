#!/usr/bin/env bash 

# stop Cassandra Daemon

ps aux | grep java | awk '{ print $2 }' | xargs kill

