#!/usr/bin/env bash
for dir in $(ls labs);
do
    echo "${dir}'s labs:"
    ls -l labs/${dir} | grep -v total | awk '{print $9}' | xargs echo "- "
done
