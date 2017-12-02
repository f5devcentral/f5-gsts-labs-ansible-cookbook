Creating a physical node
========================

Problem
-------

You need to create a node which you will assign to a pool.

Solution
--------

Use the ``bigip_node`` module. ::

   - name: An example virtual server playbook
     hosts: big-ip01
     connection: local

     vars:
       validate_certs: no
       username: admin
       password: admin

     tasks:
       - name: Create node for physical machine
         bigip_node:
           address: 10.1.20.11
           name: node-1
           password: "{{ password }}"
           server: 10.1.1.4
           user: "{{ username }}"
           validate_certs: "{{ validate_certs }}"

Discussion
----------

The ``bigip_node`` module can configure physical device addresses that can
later be added to pools. At a minimum, the ``name`` is required. Additionally,
either the ``address`` or ``fqdn`` parameters are also required when creating
new nodes.

This module can take hostnames using the ``fqdn`` parameter. You may not specify
both the ``address`` and ``fqdn``.
