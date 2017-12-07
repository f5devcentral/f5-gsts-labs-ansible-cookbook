Creating iRules from a list, with loop
======================================

Problem
-------

You need to upload a series of iRules to a BIG-IP

Solution
--------

Use the ``bigip_irule`` module and the ``loop`` keyword.

#. Change into the ``lab3.7`` directory in the ``labs`` directory.
#. Setup the filesystem layout to mirror the one :doc:`described in lab 1.3</class1/module1/lab03>`.
#. Change the ``playbooks/site.yaml`` file to resemble the following.
#. Add a ``bigip`` host to the ansible inventory and give it an ``ansible_host``
   fact with the value ``10.1.1.4``

  ::

   ---

   - name: An example looping iRule playbook
     hosts: bigip
     connection: local

     environment:
       F5_SERVER: "{{ ansible_host }}"
       F5_USER: admin
       F5_PASSWORD: admin
       F5_SERVER_PORT: 443
       F5_VALIDATE_CERTS: no

     tasks:
       - name: Create iRule in LTM
         bigip_irule:
           content: "{{ lookup('file', item.file) }}"
           module: ltm
           name: "{{ item.name }}"
         loop:
           - name: irule1
             file: ../files/irule-01.tcl
           - name: irule2
             file: ../files/irule-02.tcl
           - name: irule3
             file: ../files/irule-03.tcl

Run this playbook, from the ``lab3.7`` directory like so

  ::

   $ ansible-playbook -i inventory/hosts playbooks/site.yaml

Discussion
----------

iRules are managed on the remote system using the ``bigip_irule`` module. Since
the possibility exists though that there may be many iRules you want to upload,
one way of accomplishing that is to use the ``loop`` keyword in Ansible.

Notice that the ``loop`` keyword itself is not a parameter to the module because
it is not vertically aligned with the parameters underneath the ``bigip_irule``
YAML above.

Instead, this keyword is internal to Ansible itself. It’s available to nearly
every module. Therefore you can loop with things like pools, virtual servers,
nodes, etc.

The way to correctly read the above is, “run the ``bigip_irule`` module for each
item in the ``loop`` list”.

There are also variables in the above playbook that we haven’t seen before;
``item.name`` and ``item.file``. What do these mean?

When you use the ``loop`` construct, it will **automatically** create a variable for
you called ``item``. The value in this variable will change with each iteration of
the loop to match the value in the loop.

The dot that separates ``item`` from the other words is Ansible lingo for a method
of referring to subkeys.

In our ``loop`` list, we specified a *list of dictionaries*. A dictionary has key
names, and those names can have values of any type. In our case, the key names for
each item in the list are ``name`` and ``file``.

Therefore, when we refer to the variable ``item.name`` we are referring to the
``name`` key’s value of the current ``item`` in the list.

The above loop causes the task to run three times; one for each item in the loop.
