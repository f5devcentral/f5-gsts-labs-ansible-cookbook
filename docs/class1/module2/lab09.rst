Applying an ASM policy
======================

Problem
-------

You need to apply an ASM policy to the BIG-IP

Solution
--------

Have on-hand an ASM policy in one of the following formats

* Compact
* Non-compact
* Binary

Use the ``bigip_asm_policy`` to put the Policy on the BIG-IP and activate it.

.. NOTE::

   You will still need to add this policy to a virtual server using the
   ``bigip_virtual_server`` module.

#. Change into the ``lab2.9`` directory in the ``labs`` directory.
#. Setup the filesystem layout to mirror the one :doc:`described in lab 1.3</class1/module1/lab03>`.
#. Add a ``bigip`` host to the ansible inventory and give it an ``ansible_host``
   fact with the value ``10.1.1.4``
#. *Type* the following into the ``playbooks/site.yaml`` file.

  ::

   ---

   - name: An example ASM policy playbook
     hosts: bigip
     connection: local

     vars:
       validate_certs: no
       username: admin
       password: admin

     tasks:
       - name: Create ASM policy, compact XML file
         bigip_asm_policy:
           name: foo-policy
           file: ../files/v2_policy_compact.xml
           active: yes
           user: "{{ username }}"
           password: "{{ password }}"
           server: 10.1.1.4
           validate_certs: "{{ validate_certs }}"

Run this playbook, from the ``lab2.9`` directory like so

  ::

   $ ansible-playbook -i inventory/hosts playbooks/site.yaml

Discussion
----------

Uploading and applying ASM policies is as easy as just specifying
the policy you want to put on the device.

This module supports all of the types of policies that you can put on a
device. It will also support putting ASM policies on older versions of
BIG-IP (they changed things in or around 12.1.0)

Obviously, policies created and exported on newer releases of BIG-IP are
not backwards compatible with older releases of BIG-IP.