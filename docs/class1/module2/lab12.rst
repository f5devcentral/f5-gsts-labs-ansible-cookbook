Saving your configuration
=========================

Problem
-------

You need to save the running configuration of a BIG-IP

Solution
--------

Use the ``bigip_config`` module.

#. Create a ``lab2.12`` directory in the ``labs`` directory.
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
       - name: Save running configuration
         bigip_config:
           save: yes
           password: "{{ password }}"
           server: 10.1.1.4
           validate_certs: "{{ validate_certs }}"
           user: "{{ username }}"

Run this playbook, from the ``lab2.12`` directory like so

  ::

   $ ansible-playbook -i inventory/hosts playbooks/site.yaml

Discussion
----------

The ``bigip_config`` module has several purposes, one of which is
to save your configuration.

In addition to this, you can merge an existing configuration that you
might have (in the SCF format) into the running configuration using
the ``merge_content`` argument..

You can also reset the running configuration, should you so desire,
using the ``reset`` argument.