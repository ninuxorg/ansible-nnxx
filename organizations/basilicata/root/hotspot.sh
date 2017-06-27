#/bin/sh
TEMP=/tmp

wget https://github.com/mikysal78/nodogsplash-basilicata/archive/master.zip

opkg update
opkg install unzip

unzip master.zip -d $TEMP
rm -rf master.zip
sh $TEMP/nodogsplash-basilicata-master/install.sh


echo "Quando ha finito tutto puoi cancellare questo file,"
echo "magari dopo aver fatto un reboot."
