Firmware OpenWRT basilicata.ninux.org
=====================================

Installa i pacchetti necessari per compilare openwrt;

Debian e derivate::

    sudo apt-get install -y build-essential git libncurses5-dev zlib1g-dev unzip libssl-dev subversion

Fedora::
    dnf -y group install buildsys-build && dnf -y install git ncurses-devel openssl-devel subversion

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
