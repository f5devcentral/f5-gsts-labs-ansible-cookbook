Installing software with apt
============================

Problem
-------

You need to install apache using the on an Ubuntu host

Solution
--------

Use the ``apt`` module.

#. Create a ``lab1.7`` directory in the ``labs`` directory.
#. Setup the filesystem layout to mirror the one :doc:`described in lab 1.3</class1/module1/lab03>`.
#. Change the ``playbooks/site.yaml`` file to resemble the following.
#. Add a ``server`` host to the ansible inventory and give it an ``ansible_host``
   fact with the value ``10.1.1.6``

 ::

   ---

   - name: An example install playbook
     hosts: server

     tasks:
       - name: Install apache
         apt:
           name: apache2
           update_cache: yes

Run this playbook, from the ``lab1.7`` directory like so

  ::

   $ ansible-playbook -i inventory/hosts playbooks/site.yaml

Discussion
----------

There are different package managers for the different distributions of
Linux that exist.

In this case, we are using the ``apt`` package manager because we are on a
Debian/Ubuntu based system. On systems such as Fedora or CentOS we would
use the ``yum``, or ``dnf``, module to install similar packages.

Be aware that the name of a package *will* change depending on the package
manager being used.