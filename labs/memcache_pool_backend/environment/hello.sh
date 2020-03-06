#!/usr/bin/env bash
# setup ssh
cp -r /setup/.ssh/ /root/.ssh
chmod 700 /root/.ssh
chmod 644 /root/.ssh/config
chmod 600 /root/.ssh/id_rsa

# setup debug on underlaying libraries
for dir in $(ls /root/debug);
do
    cd /root/debug/${dir}
    if [ "debug-oslo.cache" = "$(git rev-parse --abbrev-ref HEAD)" ]; then
        continue
    fi
    # xargs is used to trim output
    debug_branch=$(git branch -a | grep "minehttp/debug-oslo.cache" | xargs)
    git fetch --all
    if [ ! -z "${debug_branch}" ]; then
        git checkout -b debug-oslo.cache ${debug_branch}
    else
        git checkout -b debug-oslo.cache
    fi
    git rebase mine/debug-oslo.cache
done
