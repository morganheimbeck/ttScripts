#!/bin/sh

# call this function with a parameter of the tag you want to checkout
# ie. checkoutBranch.sh 1.15.5

#This script should be run from root, root/www, root/www/js_app otherwise the paths will not work.
#./SyrinxChangeDir
cd www/js_app

if [ -n "$1" ]; then
    echo "tag is "$1
    git fetch -pt
    git branch -d p$1
    git checkout -b p$1 v$1
    npm install
else
    git fetch -t
    latest=$(git describe --tags --abbrev=0)
    echo "You forgot to put in a tag!"
    echo "latest tag is $latest"
fi
