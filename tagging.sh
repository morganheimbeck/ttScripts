#!/bin/sh

# RUN tagging.sh 15.5
# do not include the 'v1.', we do that already
# call this function with a parameter of the tag you want to tag and push to stash
# this will take whatever you have checked out as the tag,
# so you can checkout master, checkout a specific commit, etc.

git fetch -t
lasttag=$(git describe --tags --abbrev=0)
if [ "$1" != "" ]; then
    # git checkout master
    git tag v1.$1
    git push origin v1.$1
else
    echo "No tag specified, please run again with a tag number like 15.7"
    echo "last tag was $lasttag"
fi
