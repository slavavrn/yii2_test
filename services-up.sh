#!/bin/bash

/usr/sbin/apache2ctl start
/usr/sbin/mysqld &

while true; do
  sleep 60
done
