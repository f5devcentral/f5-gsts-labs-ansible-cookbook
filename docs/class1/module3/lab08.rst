The fallback F5 module for when there is no idempotent module
=============================================================

Problem
-------

You need to use a tmsh command that does not have an Ansible module equivalent

Solution
--------

Use the ``bigip_command`` module

#. Create a ``lab3.8`` directory in the ``labs`` directory.
#. Setup the filesystem layout to mirror the one :doc:`described in lab 1.3</class1/module1/lab03>`.
#. Add a ``bigip`` host to the ansible inventory and give it an ``ansible_host``
   fact with the value ``10.1.1.4``
#. *Type* the following into the ``playbooks/site.yaml`` file.

  ::

   ---

   - name: An example command playbook
     hosts: bigip
     connection: local

     environment:
       F5_SERVER: "{{ ansible_host }}"
       F5_USER: admin
       F5_PASSWORD: admin
       F5_SERVER_PORT: 443
       F5_VALIDATE_CERTS: no

     tasks:
       - name: Create a datagroup using tmsh
         bigip_command:
           commands: "create /ltm data-group internal applicationIdRealm type string records add { epc.foo.bar.org { data 16777264 } }"

Run this playbook, from the ``lab3.8`` directory like so

  ::

   $ ansible-playbook -i inventory/hosts playbooks/site.yaml

Discussion
----------

This module is what we recommend for all situations where you need to do
something that a current module does not support.

This module will **always** warn you when you use it for things that change
configuration. These warnings will inform you to file an issue on our Github
Issue tracker for a feature enhancement.

Ultimately, the goal we want to get to is to have a suite of modules that
meets all the needs of customers that use Ansible. Since that is not yet possible,
the ``bigip_command`` is there to accommodate.

This module can also be used over SSH, but password SSH is the only method known
to work at this time.
