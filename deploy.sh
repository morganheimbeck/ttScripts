#!/bin/sh

if [ "$tagVersion" != "" ]; then
    echo "start branch checkout"
    cd /syrinxDesktop
    sh ./scripts/checkoutBranch.sh $tagVersion;
    echo "start steal build"
    grunt --gruntfile=./www/js_app/Gruntfile.js build;
    # if not working, try this
    #/syrinxDesktop/www/js_app/node_modules/grunt-cli/bin/grunt --gruntfile='/syrinxDesktop/www/js_app/Gruntfile.js' build;
    echo "start push to cdn"
    sh ./scripts/push-to-cdn.sh tradetech-dev
    echo "done with deployment"
else
    echo "no version number passed"
fi
