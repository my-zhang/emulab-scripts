#!/usr/bin/env bash 

ps aux | grep java | awk '{ print $2 }' | xargs kill

