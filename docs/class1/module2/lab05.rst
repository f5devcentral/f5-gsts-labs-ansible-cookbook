Creating a virtual server on BIG-IP
===================================

Problem
-------

You need to create a virtual server, associated with a pool, on a BIG-IP

Solution
--------

Use the ``bigip_virtual_server`` module.

#. Create a ``lab2.5`` directory in the ``labs`` directory.
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
       - name: Create web server VIP
         bigip_virtual_server:
           description: webserver-vip
           destination: 10.1.1.100
           password: "{{ password }}"
           name: vip-1
           pool: web-servers
           port: 80
           server: 10.1.1.4
           snat: Automap
           user: "{{ username }}"
           profiles:
             - http
             - clientssl
           validate_certs: "{{ validate_certs }}"

Run this playbook, from the ``lab2.5`` directory like so

  ::

   $ ansible-playbook -i inventory/hosts playbooks/site.yaml

Discussion
----------

The ``bigip_virtual_server`` module can configure a number of attributes for a
virtual server. At a minimum, the ``name`` is required.

This module is idempotent. Therefore, you can run it over and over again
and so-long as no settings have been changed, this module will report no
changes.

Several arguments, such as ``policies`` and ``profiles`` take a list of values.
If you update this list of values, it will be reflected on the virtual
server’s configuration. This includes removing items from these lists.

As an example, if you have four items in the ``profile`` list, and then you
remove one, this will cause the virtual server to be reconfigured to only
have three profiles.