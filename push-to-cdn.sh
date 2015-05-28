#!/bin/sh

#This script should be run from root, root/www, root/www/js_app otherwise the paths will not work.
# ./SyrinxChangeDir
cd www/js_app

bucket=$1 #tradetech-dev

if [$1 = '']
then
    echo 'please specify a bucket'
else
#push up images how do we pull them down?
#push up production.html
aws s3 cp ./../production.html s3://$bucket/syrinxdesktop-built/public/

#push up images
aws s3 sync ./../images_app/ s3://$bucket/syrinxdesktop-built/public/media/images/

#push up js
aws s3 cp ./dist/bundles/tt/*.js s3://$bucket/syrinxdesktop-built/public/media/js/

#push up css
aws s3 cp ./dist/bundles/tt/*.css s3://$bucket/syrinxdesktop-built/public/media/css/
aws s3 cp ./css_app/quote-pdf.css s3://$bucket/syrinxdesktop-built/public/media/css/

fi
