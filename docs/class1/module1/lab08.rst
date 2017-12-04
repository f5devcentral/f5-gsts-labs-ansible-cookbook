Writing general files to a remote device
========================================

Problem
-------

You need to write the contents of a file (literal) to a remote location

Solution
--------

Use the ``copy`` module.

#. Create a ``lab1.8`` directory in the ``labs`` directory.
#. Setup the filesystem layout to mirror the one :doc:`described in lab 1.3</class1/module1/lab03>`.
#. Change the ``playbooks/site.yaml`` file to resemble the following.
#. Add a ``server`` host to the ansible inventory and give it an ``ansible_host``
   fact with the value ``10.1.1.6``

 ::

   - name: An example copy playbook
     hosts: server

     tasks:
       - name: Copy a local file to the remote system
         copy:
           src: cirros-0.3.5-x86_64-disk.img
           dest: /var/www/html/cirros-0.3.5-x86_64-disk.img

Run this playbook, from the ``lab1.8`` directory like so

  ::

   $ ansible-playbook -i inventory/hosts playbooks/site.yaml

Discussion
----------

This module will take a given file, and put it on a remote system at the
destination that you specify.

This module is idempotent. That means that if the remote file exists, it
will **not** overwrite it upon subsequent runs of the playbook.

This module, like all of the standard Ansible modules, works over SSH.
Therefore, the accounts used will be those implicitly used by Ansible
unless you specify otherwise.

Ansible will SSH as the user running the playbook (by default) and use
the SSH public key for that user (by default).

Default  Ansible modules (those that use SSH) will work on BIG-IP versions
>= 12.0.0. They require though that your SSH user be configured to use the
“advanced” shell. They will not work using the tmsh shell.