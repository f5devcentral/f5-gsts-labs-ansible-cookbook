Creating roles
==============

Problem
-------

You need to reuse the work you have just done in other playbooks without
repeatedly writing tasks.

Solution
--------

Use Roles.

*You may combine any set of Tasks that we have used previously in this role.*

A role is an abstraction in which a *directory named after the role* is created
in the ``roles`` directory. In the first module, we learned about the
:doc:`expected file layout</class1/module1/lab03>`. Part of this layout is a ``roles``
directory. It is that directory in which you put the role directory.

#. Change into the ``lab3.10`` directory in the ``labs`` directory.
#. Setup the filesystem layout to mirror the one :doc:`described in lab 1.3</class1/module1/lab03>`.
#. Make a role named ``app1``

  ::

   $ mkdir -p roles/app1

A role directory has the same directory structure that we created in the first
module. There are exceptions though. They are

* the ``playbooks`` directory has been replaced with ``tasks``
* there is no ``roles`` directory in a role
* there is no ``inventory`` directory in a role
* When a role is included, Ansible only calls a file named ``main.yaml`` in the
  ``tasks`` directory
* Several new directories, such as ``vars`` and ``defaults`` are available to add

With these constraints in place, we create the following directory structure
in the ``app1`` directory.

  ::

   .
   ├── defaults
   │   └── main.yaml
   ├── files
   ├── tasks
   │   └── main.yaml
   └── templates

With this structure in place, we can cherry pick Tasks from any of our other
Playbook we have written and add them to the ``tasks/main.yaml`` file.

Our app1 role will do the following

1. consume a ``tenant`` variable, defaulting to ``Common``
2. consume a ``bigip_port`` variable, defaulting to ``443``
3. consume a ``validate_certs`` variable, defaulting to ``no``
4. consume a ``bigip_username`` variable
5. consume a ``bigip_password`` variable
6. consume a ``bigip_server`` variable
7. fail if any of the variables above are not defined
8. create a partition using the name of the ``tenant`` variable
9. create a pool named ``app1-pool`` on the ``tenant`` partition. Use the round-robin
   load balancing method
10. create a single iRule using one of the same iRule files we used from
    :doc:`the earlier lab</class1/module1/lab03>`. Name it ``irule1``
11. create a virtual server named ``app1-vs`` on the ``tenant`` partition.
    Assign it the iRule and pool you created. It should have a destination of
    10.1.10.240 and a port of 80. Finally, set ``snat`` to ``Automap``
12. create a node for each host in the playbook using the current ``ansible_host``
    IP address
13. add the node to the ``app1-pool`` pool
14. Save the running configuration

To accomplish the above, let’s do the following

Construct a playbook to use your role
`````````````````````````````````````

Create the file ``playbooks/site.yaml`` in the ``lab3.10`` directory; **not** the role directory. Put the following in it.

  ::

   ---

   - name: Use app1 role
     hosts: app1
     connection: local

     vars_prompt:
       - name: bigip_username
         prompt: "Enter the BIG-IP username"
         private: no
       - name: bigip_password
         prompt: "Enter the BIG-IP password"
         private: yes
       - name: bigip_server
         prompt: "Enter the BIG-IP server address"
         private: no

     roles:
       - app1

This is the playbook we will use.

Create default variables
````````````````````````

In the ``app1`` role directory, edit the ``defaults/main.yaml`` file, add the following

  ::

   ---

   tenant: Common
   bigip_port: 443
   validate_certs: no

This accomplishes bullets #1 to #3

Create a setup task list
````````````````````````

Create the file ``tasks/setup.yaml``

In this file, put the following

  ::

   ---

   - name: Check to see if bigip username credential missing
     fail:
       msg: "You must provide a 'bigip_username' variable"
     when: bigip_username is not defined

   - name: Check to see if bigip passwrd credential missing
     fail:
       msg: "You must provide a 'bigip_password' variable"
     when: bigip_password is not defined

   - name: Check to see if bigip server credential missing
     fail:
       msg: "You must provide a 'bigip_server' variable"
     when: bigip_server is not defined

This accomplishes bullets #4 to #7

Create a main task list
```````````````````````

Edit the ``tasks/main.yaml`` file to include the following

  ::

   ---

   - import_tasks: setup.yaml

   - name: Create tenant partition
     bigip_partition:
       name: "{{ tenant }}"
       user: "{{ bigip_username }}"
       password: "{{ bigip_password }}"
       validate_certs: "{{ validate_certs }}"
       server: "{{ bigip_server }}"
       server_port: "{{ bigip_port }}"
     delegate_to: localhost

   - name: Create pool
     bigip_pool:
       name: "{{ tenant }}-pool1"
       lb_method: round-robin
       partition: "{{ tenant }}"
       user: "{{ bigip_username }}"
       password: "{{ bigip_password }}"
       validate_certs: "{{ validate_certs }}"
       server: "{{ bigip_server }}"
       server_port: "{{ bigip_port }}"
     delegate_to: localhost

   - name: Create iRule
     bigip_irule:
       content: "{{ lookup('file', 'irule-01.tcl') }}"
       module: ltm
       name: irule1
       partition: "{{ tenant }}"
       user: "{{ bigip_username }}"
       password: "{{ bigip_password }}"
       validate_certs: "{{ validate_certs }}"
       server: "{{ bigip_server }}"
       server_port: "{{ bigip_port }}"
     delegate_to: localhost

   - name: Create virtual server
     bigip_virtual_server:
       name: app1-vs
       destination: "{{ vs_destination }}"
       port: 80
       irules:
         - irule1
       profiles:
         - http
       snat: Automap
       partition: "{{ tenant }}"
       user: "{{ bigip_username }}"
       password: "{{ bigip_password }}"
       validate_certs: "{{ validate_certs }}"
       server: "{{ bigip_server }}"
       server_port: "{{ bigip_port }}"
     delegate_to: localhost

   - name: Create node for physical machine
     bigip_node:
       address: "{{ node_destination }}"
       name: "{{ inventory_hostname }}"
       user: "{{ bigip_username }}"
       password: "{{ bigip_password }}"
       validate_certs: "{{ validate_certs }}"
       server: "{{ bigip_server }}"
       server_port: "{{ bigip_port }}"
     delegate_to: localhost

   - name: Add node to pool
     bigip_pool_member:
       pool: "{{ tenant }}-pool1"
       partition: "{{ tenant }}"
       host: "{{ node_destination }}"
       port: 80
       user: "{{ bigip_username }}"
       password: "{{ bigip_password }}"
       validate_certs: "{{ validate_certs }}"
       server: "{{ bigip_server }}"
       server_port: "{{ bigip_port }}"
     delegate_to: localhost

   - name: Save running config
     bigip_config:
       save: yes
       user: "{{ bigip_username }}"
       password: "{{ bigip_password }}"
       validate_certs: "{{ validate_certs }}"
       server: "{{ bigip_server }}"
       server_port: "{{ bigip_port }}"
     delegate_to: localhost

This accomplishes bullets #8 to #14

Move files to the appropriate directories
`````````````````````````````````````````

In the task list above, we use an iRule file. To make use of it in this role, we
need to put it in the ``files`` directory because we used the ``file`` lookup.

From the ``lab3.10`` directory, issue the following command

  ::

   cp files/irule-01.tcl roles/app1/files/

Run the playbook
````````````````

With the above in place, you can run the playbook as you normally would

  ::

   $ ansible-playbook -i inventory/hosts playbooks/site.yaml

Your play, and role, should execute as expected and configure the device.

Discussion
----------

As you can see from the solution above, a role is a way to encapsulate a body
of work. This role could have been zipped up and given to anyone else and they
could have extracted it and run it the same way that you did.

Roles can include their own files, templates, and even custom modules. They
should be your go-to solution for all your work that is beyond a single playbook.

With our solution in place, our directory structure now looks like this

  ::

   .
   ├── defaults
   │   └── main.yaml
   ├── files
   │   └── irule-01.tcl
   ├── tasks
   │   ├── main.yaml
   │   └── setup.yaml
   └── templates

Earlier I said that Ansible will **only** call the ``tasks/main.yaml`` file. That’s
perfectly ok though because we can include as many other files as we need.

We did just take with the ``import_tasks`` action in the ``tasks/main.yaml`` file.
This action will cause Ansible to read in this file and replace the import line
with the content of the file.

The ``defaults`` directory we made use of stores default variables. These variables
may be overridden via the CLI as we learned :doc:`in an earlier lab</class1/module3/lab06>`.

Notice also how when we used the file lookup, we didn’t need to refer to the full
path to the file. This is because, in roles, if you used the file lookup, Ansible
assumes the file being looked up is in the ``files`` directory of the role.

The ``template`` lookup works much the same way. If you use the following in a role

  ::

   lookup(‘template’, ‘file.txt’)

Ansible will implicitly look in the ``templates`` directory of your role.
