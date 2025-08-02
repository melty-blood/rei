#!/bin/bash

echo "-- TypeMoon --"

echo "+++ mkdir " /home/rei/update_back/$(date +%Y%m%d) "+++"
mkdir -p /home/rei/update_back/$(date +%Y%m%d)

echo "back template dir" /home/rei/update_back/$(date +%Y%m%d)/
cp -r /home/rei/sunny_peace_rei/resources/template /home/rei/update_back/$(date +%Y%m%d)/

tar -zxf template.tar.gz -C /home/rei/sunny_peace_rei/resources/

echo "update progam ------"
if [ -f "./rei" ]; then
    echo "update file 'rei' has! Now update progam"
    mv /home/rei/sunny_peace_rei/rei /home/rei/sunny_peace_rei/rei_v1
    cp ./rei /home/rei/sunny_peace_rei/rei
    chmod +x /home/rei/sunny_peace_rei/rei
    echo "Update done!"
else
    echo "Update file not has!"
fi
echo "Success! 666666"

