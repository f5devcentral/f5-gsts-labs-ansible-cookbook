Provisioning ASM
================

Problem
-------

You need to provision ASM on the BIG-IP

Solution
--------

Use the ``bigip_provision`` module. ::

   - name: An example provision playbook
     hosts: big-ip01
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