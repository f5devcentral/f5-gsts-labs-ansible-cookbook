Templating a file to a remote device
====================================

Problem
-------

You need to write the contents of a file (containing variables) to a remote location

Solution
--------

Use the ``template`` module.

#. Create a ``lab1.9`` directory in the ``labs`` directory.
#. Setup the filesystem layout to mirror the one :doc:`described in lab 1.3</class1/module1/lab03>`.
#. Change the ``playbooks/site.yaml`` file to resemble the following.
#. Add a ``server`` host to the ansible inventory and give it an ``ansible_host``
   fact with the value ``10.1.1.6``

 ::

   ---

   - name: An example template playbook
     hosts: server

     tasks:
       - name: Template a file to disk
         template:
           src: ../templates/sample-template.txt
           dest: /tmp/sample-template.txt

This playbooks requires a file named ``sample-template.txt`` be created in the ``templates``
directory of your lab. Therefore, create this file. You can put in it any text you want. How
about,

  ::

   This was uploaded by Ansible. The remote machine info is,
   name: {{ inventory_hostname }}
   ip: {{ ansible_host }}

Run this playbook, from the ``lab1.9`` directory like so

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

Ansible will SSH as the user running the playbook (by default) and use the
SSH public key for that user (by default).

Default  Ansible modules (those that use SSH) will work on BIG-IP versions
>= 12.0.0. They require though that your SSH user be configured to use the
“advanced” shell. They will not work using the tmsh shell.