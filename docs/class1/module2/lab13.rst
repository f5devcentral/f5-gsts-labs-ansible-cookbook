Waiting for your device to (re)boot
===================================

Problem
-------

You need to reboot the BIG-IP and wait for it to come back up

Solution
--------

Reboot the device with ``bigip_command``, then use ``bigip_wait`` to wait
for the device to come back up and be ready to take configuration.

#. Create a ``lab2.13`` directory in the ``labs`` directory.
#. Setup the filesystem layout to mirror the one :doc:`described in lab 1.3</class1/module1/lab03>`.
#. Add a ``bigip`` host to the ansible inventory and give it an ``ansible_host``
   fact with the value ``10.1.1.4``
#. *Type* the following into the ``playbooks/site.yaml`` file.

  ::

   ---

   - name: An example configuration saving playbook
     hosts: bigip
     connection: local

     vars:
       validate_certs: no
       username: admin
       password: admin

     tasks:
       - name: Reboot BIG-IP
         bigip_command:
           commands: tmsh reboot
           user: "{{ username }}"
           password: "{{ password }}"
           server: 10.1.1.4
           validate_certs: "{{ validate_certs }}"
         ignore_errors: true

       - name: Wait for shutdown to happen
         pause:
           seconds: 90

       - name: Wait for BIG-IP to actually be ready
         bigip_wait:
           user: "{{ username }}"
           password: "{{ password }}"
           server: 10.1.1.4
           validate_certs: "{{ validate_certs }}"

Run this playbook, from the ``lab2.13`` directory like so

  ::

   $ ansible-playbook -i inventory/hosts playbooks/site.yaml

Discussion
----------

Waiting for the BIG-IP to be available is actually a really difficult thing
to do. It gets better in later versions of BIG-IP (13.1 and beyond). For those
and all the earlier releases (back to 12.0.0) you can use this module.

This module will not return until the BIG-IP is ready to take configuration.
This means that it will wait for,

* mcpd
* iControl REST
* ASM
* vCMP

Notice that I mentioned several features that themselves are problematic to
wait for. This module will accommodate them.

Once this module returns (and Ansible moves on to the next Task) you will be
able to use any F5 Ansible module that would change the configuration.