Installing software with apt
============================

Problem
-------

You need to install apache using the on an Ubuntu host

Solution
--------

Use the ``apt`` module. ::

   - name: An example install playbook
     hosts: server

     tasks:
       - name: Copy a local file to the remote system
         apt:
           name: apache2
           update_cache: yes

Discussion
----------

There are different package managers for the different distributions of
Linux that exist.

In this case, we are using the ``apt`` package manager because we are on a
Debian/Ubuntu based system. On systems such as Fedora or CentOS we would
use the ``yum``, or ``dnf``, module to install similar packages.

Be aware that the name of a package *will* change depending on the package
manager being used.