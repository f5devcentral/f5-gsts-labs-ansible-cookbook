Creating an LTM policy with rules
=================================

Problem
-------

You need to create an LTM policy with an ASM rule on a BIG-IP

Solution
--------

Use the ``bigip_policy`` module to create a policy with a generic rule.
Then use the ``bigip_policy_rule`` module to modify the ``actions`` and ``conditions``
on that rule as needed.

#. Change into the ``lab2.10`` directory in the ``labs`` directory.
#. Setup the filesystem layout to mirror the one :doc:`described in lab 1.3</class1/module1/lab03>`.
#. Add a ``bigip`` host to the ansible inventory and give it an ``ansible_host``
   fact with the value ``10.1.1.4``
#. *Type* the following into the ``playbooks/site.yaml`` file.

  ::

   ---

   - name: An example LTM policy playbook
     hosts: bigip
     connection: local

     vars:
       validate_certs: no
       username: admin
       password: admin
       policy_name1: my-ltm-policy

     tasks:
       - name: Provision ASM
         bigip_provision:
           module: asm
           password: "{{ password }}"
           server: 10.1.1.4
           validate_certs: "{{ validate_certs }}"
           user: "{{ username }}"

       - name: Create ASM policy
         bigip_asm_policy:
           name: foo-policy
           file: ../files/v2_policy_compact.xml
           password: "{{ password }}"
           server: 10.1.1.4
           validate_certs: "{{ validate_certs }}"
           user: "{{ username }}"

       - name: Create published policy with 1 stubbed rule
         bigip_policy:
           name: "{{ policy_name1 }}"
           state: present
           rules:
             - rule1
           password: "{{ password }}"
           server: 10.1.1.4
           validate_certs: "{{ validate_certs }}"
           user: "{{ username }}"

       - name: Attach ASM policy to LTM policy rule
         bigip_policy_rule:
           policy: "{{ policy_name1 }}"
           name: rule1
           actions:
             - type: enable
               asm_policy: foo-policy
           password: "{{ password }}"
           server: 10.1.1.4
           validate_certs: "{{ validate_certs }}"
           user: "{{ username }}"

Run this playbook, from the ``lab2.10`` directory like so

  ::

   $ ansible-playbook -i inventory/hosts playbooks/site.yaml

Discussion
----------

The ``bigip_policy`` module is used for several purposes.

First, it creates the containers that can actually contain rules.

Second, it is used to stub out lists of rules before you actually configure
those rules. This is handy when you need to arrange the rule order of the policy.
Since rules can be applied in a specific order, using the ``bigip_policy`` module
can set that order (using stub rules) before you actually go about creating the
rules.

If you create rules *later*, they will *always* be appended to the list of
current rules. Obviously this may not be what you want, so the ``bigip_policy``
module can be used to re-arrange them. Just specify the list of rules in the
order you want them applied.

At the time of this writing, only a handful of ``conditions`` and ``actions`` are
available for use in the ``bigip_policy_rule`` module. You may :doc:`file an issue</class1/module4/lab3>`.
if you need a particular condition or action added.

Available ``conditions`` types are,

* ``http_uri``
* ``all_traffic``

Available ``actions`` types are

* ``forward`` (this is used in conjunction with pools)
* ``enable`` (this is used in conjunction with ASM policies)
* ``ignore``

In addition to these types, there is also (usually) a value that you will
supply so that a particular type can take effect. These are all documented
in the **ansible-doc** for the ``bigip_policy_rule`` module.

Some of them are

* ``path_begins_with_any``
* ``asm_policy``
* ``pool``

The documentation outlines which values to specify in which cases.