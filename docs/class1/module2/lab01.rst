Creating a pool on BIG-IP
=========================

Problem
-------

You need to create a pool on a BIG-IP

Solution
--------

Use the ``bigip_pool`` module.

#. Create a ``lab2.1`` directory in the ``labs`` directory.
#. Setup the filesystem layout to mirror the one :doc:`described in lab 1.3</class1/module1/lab03>`.
#. Add a ``bigip`` host to the ansible inventory and give it an ``ansible_host``
   fact with the value ``10.1.1.4``
#. *Type* the following into the ``playbooks/site.yaml`` file.

 ::

   ---

   - name: An example pool playbook
     hosts: bigip
     connection: local

     tasks:
       - name: Create web servers pool
         bigip_pool:
           name: web-servers
           lb_method: ratio-member
           password: admin
           server: 10.1.1.4
           user: admin
           validate_certs: no

Run this playbook, from the ``lab2.1`` directory like so

  ::

   $ ansible-playbook -i inventory/hosts playbooks/site.yaml

Discussion
----------

The ``bigip_pool`` module can configure a number of attributes for a pool.
At a minimum, the ``name`` is required.

This module is idempotent. Therefore, you can run it over and over again and
so-long as no settings have been changed, this module will report no changes.

Notice how we also included the credentials to log into the device as arguments
to the task. This is *not* the preferred way to do this, but it illustrates a
way for beginners to get started without needing to know a less obvious way to
specify these values.

The module has several more options, all of which can be seen at `this link`_.
I have reproduced them below. These are relevant to the 2.5 release of Ansible.

* ``description``
* ``lb_method``
* ``monitor_type``
* ``monitors``
* ``name``
* ``quorum``
* ``reselect_tries``
* ``service_down_action``
* ``slow_ramp_time``

.. _this link: http://docs.ansible.com/ansible/latest/bigip_pool_module.html