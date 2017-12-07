Provisioning ASM
================

Problem
-------

You need to provision ASM on the BIG-IP

Solution
--------

Use the ``bigip_provision`` module.

#. Create a ``lab2.8`` directory in the ``labs`` directory.
#. Setup the filesystem layout to mirror the one :doc:`described in lab 1.3</class1/module1/lab03>`.
#. Add a ``bigip`` host to the ansible inventory and give it an ``ansible_host``
   fact with the value ``10.1.1.4``
#. *Type* the following into the ``playbooks/site.yaml`` file.

 ::

   ---

   - name: An example provision playbook
     hosts: bigip
     connection: local

     vars:
       validate_certs: no
       username: admin
       password: admin

     tasks:
       - name: Provision ASM
         bigip_provision:
           name: asm
           password: "{{ password }}"
           server: 10.1.1.4
           validate_certs: "{{ validate_certs }}"
           user: "{{ username }}"

Run this playbook, from the ``lab2.8`` directory like so

  ::

   $ ansible-playbook -i inventory/hosts playbooks/site.yaml

Discussion
----------

The ``bigip_provision`` module can provision and de-provision modules from
the system.

This module will wait for a provisioning action to fully complete before
it allows the Playbook to proceed to the next task. This includes waiting
for the system to reboot and for MCPD to come online and be ready to take
new configuration.

All of the above also applies to ASM.

The level that all modules are provisioned at is ``nominal`` by default. This
can be changed using the ``level`` argument. Valid choices are,

* ``dedicated``
* ``nominal``
* ``minimum``

This module is smart enough to known when certain modules require specific
provisioning levels. For example, vCMP is always ``dedicated``.