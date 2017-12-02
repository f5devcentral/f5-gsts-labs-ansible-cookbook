Adding nodes to a pool
======================

Problem
-------

You need to assign newly created nodes to a pool

Solution
--------

Use the ``bigip_pool_member`` module. ::

   - name: An example pool members playbook
     hosts: big-ip01
     connection: local

     vars:
       validate_certs: no
       username: admin
       password: admin

     tasks:
       - name: Add nodes to pool
         bigip_pool_member:
           description: webserver-1
           host: 10.1.20.11
           name: node-1
           password: "{{ password }}"
           pool: web-servers
           port: 80
           server: 10.1.1.4
           user: "{{ username }}"
           validate_certs: "{{ validate_certs }}"

Discussion
----------

The ``bigip_pool_member`` module can configure pools with the details of
existing nodes. A node that has been placed in a pool is referred to as
a “pool member”.

At a minimum, the ``name`` is required. Additionally, the ``host`` is required
when creating new pool members.
