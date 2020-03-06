#!/usr/bin/env bash
# backup debug on underlaying libraries
for dir in $(ls /root/debug);
do
    cd /root/debug/${dir}
    # xargs is used to trim output
    git add .
    git commit -m "debug"
    git push mine debug-oslo.cache
done
