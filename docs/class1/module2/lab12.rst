Saving your configuration
=========================

Problem
-------

You need to save the running configuration of a BIG-IP

Solution
--------

Use the ``bigip_config`` module. ::

   - name: An example configuration saving playbook
     hosts: big-ip01
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

Discussion
----------

The ``bigip_config`` module has several purposes, one of which is
to save your configuration.

In addition to this, you can merge an existing configuration that you
might have (in the SCF format) into the running configuration using
the ``merge_content`` argument..

You can also reset the running configuration, should you so desire,
using the ``reset`` argument.