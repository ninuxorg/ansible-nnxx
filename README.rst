Firmware OpenWRT basilicata.ninux.org
=====================================

Clona questo repository::

    git clone https://github.com/ninuxorg/openwrt-basilicata.git

Lancia la compilazione, ad esempio::

    ./compile.sh -j 16 --www "/var/www" --archs "ar71xx rampis" --release 15.05

Consulta le opzioni disponibili::

    ./compile --help

Personalizzare i pacchetti
==========================

E' possibile personalizzare i pacchetti selezionati di default
copiando i seguenti file::

    cp .config.default .config
    cp feeds.conf.default feeds.conf

Dopo aver copiato le impostazioni di default basterà modificare i file:

* ``.config``
* ``feeds.conf``
