#!/bin/sh

 # This script takes a zipped file and a qualifier as input and adds them to our app

clear

# Gather Variables

 echo "This is the logo publishing script. Make sure you have uploaded the .zip file to this directory from Phil immediately before executing this script. You need a git repo in your home directory to execute this."
 echo
 echo
 echo "Enter the name of the qualifier you wish these images to go to, followed by [ENTER]:"
 read CASE


 for FILE in *\ *; do if [ -f "$FILE" ]; then mv "$FILE" ${FILE// /_}; fi; done

 USER=$(whoami);
 QUAL=$(echo $CASE | tr '[:upper:]' '[:lower:]');
 echo "Please provide the path and name of the zipped folder. If you path has spaces, this script has already changed the spaces to underscores. Here is a current directory listing:"
ls -lah
echo
 read philfile 
 echo
while true; do
    read -p "Is $philfile your zipped folder? yes/no:" yn
    case $yn in
        [Yy]* ) make install; break;;
        [Nn]* ) echo "please reload your archive and execute this script again. For this script to work, the zipped archive must be the most recently modified file in the folder this script was executed in. You can use the command 'touch (yourfile).zip' to trigger this"; exit ;;
        * ) echo "Please answer yes or no.";;
    esac
done


# Make a folder with the qualifier given and unzip phil's images into it

 QUALDIR="~/WebstormProjects/syrinx/desktop/www/images_app/global/co_brand/$CASE";

 mkdir $QUALDIR;




 unzip $philfile -d $QUALDIR;
 mv $philfile $QUALDIR;

 # Rename the files and mv them to the main folder

 cd $QUALDIR
 rm -rf __MACOSX/

 find -name "*140x38*" -exec mv {} small_logo.png \;
 find -name "*f0f0f0*" -exec mv {} map_logo.png \;
 find -name "*ffffff*" -exec mv {} quote_logo.png \;

 # Add css to themes.less in your home directory

 echo
 echo
 echo "The following lines were added to main.css in the git repo of $USER.";
 echo
 echo
 echo "/*$CASE -- Created on `date`
---------------------------------
*/

 #$QUAL {
     #cobrand_logo {
         background: url(\"@{images-co-brand}$CASE/small_logo.png\") no-repeat;
     }
     .map-logo {
         background: url(\"@{images-co-brand}$CASE/map_logo.png\") 0px 0px no-repeat;
     }
     .quote_logo {
         background: url(\"@{images-co-brand}$CASE/quote_logo.png\") 50% 0px no-repeat;
     }
 }" | tee associated_css.txt;

line=/create_logo.sh/
tmp="./themes.less"
sed -e "${line}r associated_css.txt" ~/WebstormProjects/syrinx/desktop/www/js_app/css_app/themes.less > $tmp
mv themes.less ~/WebstormProjects/syrinx/desktop/www/js_app/css_app/themes.less;
rm associated_css.txt;
rm $philfile
 echo
 echo
 echo "All done! *******REMEMBER TO TEST(clear your cache) AND PUSH your changes.************";
 echo
 echo
