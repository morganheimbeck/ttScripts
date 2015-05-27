#!/bin/sh

# call this function with a parameter of the tag you want to checkout
# ie. checkoutBranch.sh 1.15.5

#This script should be run from the project root directory at least, SyrinxDesktop.stable/www, root/www/js_app otherwise the paths will not work.
CURRENT_DIR=$(pwd)

if [[ $CURRENT_DIR =~ "www/js_app" ]]
then
    echo "dont have to go anywhere"
elif [[ $CURRENT_DIR =~ "www" ]]
then
    echo "moving to js_app"
    cd js_app
elif [[ $CURRENT_DIR =~ "scripts" ]]
then
    echo "moving up one and down to www/js_app"
    cd ../www/js_app
else
    echo "moving to www/js_app"
    cd www/js_app
fi

if [ "$1" != "" ]; then
    echo "tag is "$1
    git fetch -p
    git branch -d p$1
    git checkout -b p$1 v$1
    npm install
    bower install --allow-root --config.interactive=false
else
    git fetch -t
    latest=$(git describe --tags --abbrev=0)
    echo "You forgot to put in a tag!"
    echo "latest tag is $latest"
fi
