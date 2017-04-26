NNXX ansible configurations
===========================

.. image:: https://raw.githubusercontent.com/ninuxorg/nnxx-firmware/master/docs/nnxx.png
   :target: http://wiki.ninux.org/nnxx

.. contents:: **Table of Contents**:
   :backlinks: none
   :depth: 3

Introduction
============

This repository contains the ansible configurations of the various components that are being used
in the `NNXX (Ninux Experimental) <http://wiki.ninux.org/nnxx>`_ infrastructure (ninux experimental).

Firmware
========

The firmware is based on `OpenWRT <https://openwrt.org/>`_ and the following additional software:

- olsrd2
- luci-ssl
- openvpn
- openwisp-config

The firmware images are managed via `ansible-openwisp2-imagegenerator
<https://github.com/openwisp/ansible-openwisp2-imagegenerator>`_, an ansible role that allows
to build several openwrt firmware images for different organizations while keeping track of their configurations
(for more information regarding the process, see the project's README).

Requirements
============

* a debian/ubuntu based VM
* root access
* at least 100 GB of free space

Compiling
---------

**Note**: please take some time to read about the `build process of ansible-openwisp2-imagegenerator
<https://github.com/openwisp/ansible-openwisp2-imagegenerator#build-process>`_.

First of all, you have to install the ``openwisp.openwisp2-imagegenerator`` role via *ansible-galaxy*::

    ansible-galaxy install openwisp.openwisp2-imagegenerator

In order to compile the firmware, you need to have access to one of the hosts listed in the `hosts
<https://github.com/ninuxorg/ansible-nnxx/blob/master/hosts>`_, preferably via an SSH key installed on the server.

Recompile the image builders and build all the images::

    ansible-playbook -i hosts firmware.yml -l builder -u <user> -e "recompile=1 cores=4"

After the first compilation, you can avoid recompiling again by running::

    ansible-playbook -i hosts firmware.yml -l builder -u <user>

Run only the building steps by using the specific tags::

    ansible-playbook -i hosts firmware.yml -l builder -u <user> -t generator,build

Compiling on a private host
---------------------------

To compile on a different host than the ones specified in the `hosts
<https://github.com/ninuxorg/ansible-nnxx/blob/master/hosts>`_ file, create a ``private_hosts`` file::

    [builder]
    my.project.org ansible_user=user ansible_port=22

Now run::

    ansible-playbook -i private_hosts firmware.yml -l builder -e "recompile=1 cores=4"
