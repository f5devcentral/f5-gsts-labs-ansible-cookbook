Templating a file to a remote device
====================================

Problem
-------

You need to write the contents of a file (containing variables) to a remote location

Solution
--------

Use the ``template`` module. ::

   - name: An example copy playbook
     hosts: server

     tasks:
       - name: Template apache configuration to disk
         template:
           src: httpd.conf
           dest: /etc/apache2/000-default

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