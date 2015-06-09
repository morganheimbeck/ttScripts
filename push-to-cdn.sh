#!/bin/sh

#This script should be run from root, root/www, root/www/js_app otherwise the paths will not work.
# ./SyrinxChangeDir
cd www/js_app

#./push-to-cdn.sh tradetech-dev
if [$1 = '']
then
    echo 'please specify a bucket'
else
    #push up images how do we pull them down?
    #push up production.html
    aws s3 cp ./../production.html s3://$1/public/syrinxdesktop/

    #push up images
    aws s3 sync ./../images_app/ s3://$1/public/syrinxdesktop/media/images/
    aws s3 cp ./../favicon.ico s3://$1/public/syrinxdesktop/

    #push up js
    aws s3 cp ./dist/bundles/tt/*.js s3://$1/public/syrinxdesktop/media/js/

    #push up css
    aws s3 cp ./dist/bundles/tt/*.css s3://$1/public/syrinxdesktop/media/css/
    aws s3 cp ./css_app/quote-pdf.css s3://$1/public/syrinxdesktop/media/css/

fi
