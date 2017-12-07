Writing once, re-using many times
=================================

Problem
-------

You want to specify the values for user/pass and validate_certs only once
but re-use them throughout your tasks

Solution
--------

Use variables.

#. Create a ``lab2.2`` directory in the ``labs`` directory.
#. Setup the filesystem layout to mirror the one :doc:`described in lab 1.3</class1/module1/lab03>`.
#. Add a ``bigip`` host to the ansible inventory and give it an ``ansible_host``
   fact with the value ``10.1.1.4``
#. *Type* the following into the ``playbooks/site.yaml`` file.

 ::

   ---

   - name: An example copy playbook
     hosts: bigip

     vars:
       validate_certs: no
       username: admin
       password: admin

     tasks:
       - name: Create many pools
         bigip_pool:
           name: web-servers
           lb_method: ratio-member
           password: "{{ password }}"
           server: 10.1.1.4
           user: "{{ username }}"
           validate_certs: "{{ validate_certs }}"

Run this playbook, from the ``lab2.2`` directory like so

  ::

   $ ansible-playbook -i inventory/hosts playbooks/site.yaml

Discussion
----------

Variables are one of the ways in which you can set a value once and re-use it
across many tasks in your Play.

It should be noted that variables **do not** survive across Plays. Therefore,
if you need to use them in multiple plays, it is better to put them in a
``host_vars`` or ``group_vars`` file.

Variables are identified by their double curly braces (``{{`` and ``}}``). The value
in-between these braces is the variable name.

Notice how we set our variables at the top of the play in the ``vars`` section.
This is a special section of the Playbook where you can specify variable data
that will be used across this Play and this Play only.

When using variables, they *must* be wrapped in double quotes. You can see this
in the ``bigip_pool`` task for the ``password``, ``user``, and ``validate_certs``
arguments.