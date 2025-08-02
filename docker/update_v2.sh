#!/bin/bash

echo "-- IchinoseRei --"

echo "+++ mkdir " /home/rei/update_back/$(date +%Y%m%d) "+++"
mkdir -p /home/rei/update_back/$(date +%Y%m%d)

if [ -f "./confnew/config.yaml" ]; then
    echo "update config has! Now update."
    cp -r ./confnew/config.yaml /home/rei/sunny_peace_rei/conf/config.yaml
    echo "Update config done!"
else
    echo "Update config not has!"
fi

if [ -f "./template.tar.gz" ]; then
    echo "update template has! Now update."

    echo "back template dir" /home/rei/update_back/$(date +%Y%m%d)/
    cp -r /home/rei/sunny_peace_rei/resources/template /home/rei/update_back/$(date +%Y%m%d)/
    tar -zxf template.tar.gz -C /home/rei/sunny_peace_rei/resources/
    echo "Update template done!"
else
    echo "Update template not has!"
fi

echo "update progam ------"
if [ -f "./rei" ]; then
    echo "update file 'rei' has! Now update progam"
    mv /home/rei/sunny_peace_rei/rei /home/rei/update_back/$(date +%Y%m%d)/rei

    cp ./rei /home/rei/sunny_peace_rei/rei
    chmod +x /home/rei/sunny_peace_rei/rei
    echo "Update done!"
else
    echo "Update file not has!"
fi
echo "Success! 666666"
