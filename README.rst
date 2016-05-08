NNXX firmware
=============

.. image:: https://raw.githubusercontent.com/ninuxorg/nnxx-firmware/master/docs/nnxx.png
   :target: http://wiki.ninux.org/nnxx

.. contents:: **Table of Contents**:
   :backlinks: none
   :depth: 3

Introduzione
------------

Questo repository contiene degli script che aiutano a compilare il firmware
utilizzato sulle isole che stanno partecipando a `NNXX (Ninux Experimental) <http://wiki.ninux.org/nnxx>`_.

Il firmware è basato su `LEDE <https://www.lede-project.org/>`_ ed i seguenti pacchetti:

- olsrd2
- luci-ssl
- openvpn
- openwisp-config

I pacchetti ed i feed sono personalizzabili in caso di necessità, per maggiori
informazioni vedere `Personalizzazione feed e pacchetti abilitati <#personalizzazione-feed-e-pacchetti-abilitati>`_.

Come si compila
---------------

Installa i pacchetti necessari per compilare `LEDE <https://www.lede-project.org/>`_;

Debian / Ubuntu e derivate::

    sudo apt-get install -y build-essential git libncurses5-dev zlib1g-dev unzip libssl-dev subversion

Fedora::

    dnf -y group install buildsys-build && dnf -y install git openssl-devel ncurses-devel subversion zlib-devel

CentOS / Red Hat Enterprise Linux / Scientific Linux::

    yum -y install epel-release && yum -y group install buildsys-build && yum -y install git openssl-devel ncurses-devel subversion zlib-devel

Clona questo repository::

    git clone https://github.com/ninuxorg/nnxx-firmware.git

Lancia la compilazione, ad esempio::

    ./compile.sh --archs "ar71xx rampis" -j 16

Consulta le opzioni disponibili::

    ./compile --help

Personalizzazione feed e pacchetti abilitati
--------------------------------------------

E' possibile personalizzare i pacchetti ed i feed abilitati di default in
questo modo::

    cp .config.default .config
    cp feeds.conf.default feeds.conf

Dopo aver copiato le impostazioni di default basterà modificare i file:

* ``.config``
* ``feeds.conf``

Questi due file sono presenti nel ``.gitignore``, per questo motivo le personalizzazioni
non verranno incluse in eventuali cambiamenti della history del repository.
