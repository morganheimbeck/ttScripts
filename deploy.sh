#!/bin/sh

if [ "$tagVersion" != "" ]; then
    echo "start branch checkout"
    cd /syrinxDesktop
    sh /syrinxDesktop/scripts/checkoutBranch.sh $tagVersion;
    echo "start steal build"
    grunt --gruntfile=/syrinxDesktop/www/js_app/Gruntfile.js build;
    # if not working, try this
    #/syrinxDesktop/www/js_app/node_modules/grunt-cli/bin/grunt --gruntfile='/syrinxDesktop/www/js_app/Gruntfile.js' build;
    echo "start push to cdn"
    sh /syrinxDesktop/scripts/push-to-cdn.sh
    echo "done with deployment"
else
    echo "no version number passed"
fi
