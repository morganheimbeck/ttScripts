#!/bin/sh

cd /syrinxDesktop/www/js_app/;
if ["$1" != ""]; then
    checkoutBranch.sh $1;
    grunt build;
    ../../scripts/push-to-cdn.sh
fi
