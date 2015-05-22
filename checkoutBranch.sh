#!/bin/sh

# call this function with a parameter of the tag you want to checkout
# ie. checkoutBranch.sh 1.15.5

# THIS MUST BE RUN FROM www/js_app
# this is because git, npm, and bower should all function from there
# without additional annoying logic
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
