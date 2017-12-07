Creating a physical node
========================

Problem
-------

You need to create a node which you will assign to a pool.

Solution
--------

Use the ``bigip_node`` module.

#. Create a ``lab2.3`` directory in the ``labs`` directory.
#. Setup the filesystem layout to mirror the one :doc:`described in lab 1.3</class1/module1/lab03>`.
#. Add a ``bigip`` host to the ansible inventory and give it an ``ansible_host``
   fact with the value ``10.1.1.4``
#. *Type* the following into the ``playbooks/site.yaml`` file.

 ::

   ---

   - name: An example virtual server playbook
     hosts: bigip
     connection: local

     vars:
       validate_certs: no
       username: admin
       password: admin

     tasks:
       - name: Create node for physical machine
         bigip_node:
           address: 10.1.20.11
           name: server
           password: "{{ password }}"
           server: 10.1.1.4
           user: "{{ username }}"
           validate_certs: "{{ validate_certs }}"

Run this playbook, from the ``lab2.3`` directory like so

  ::

   $ ansible-playbook -i inventory/hosts playbooks/site.yaml

Discussion
----------

The ``bigip_node`` module can configure physical device addresses that can
later be added to pools. At a minimum, the ``name`` is required. Additionally,
either the ``address`` or ``fqdn`` parameters are also required when creating
new nodes.

This module can take hostnames using the ``fqdn`` parameter. You may not specify
both the ``address`` and ``fqdn``.
