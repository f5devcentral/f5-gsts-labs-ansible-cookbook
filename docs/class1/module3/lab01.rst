Prompting for user input
========================

Problem
-------

You need to prompt the user to provide a password to Ansible

Solution
--------

Use the ``vars_prompt`` block in your Playbook.

#. Create a ``lab3.1`` directory in the ``labs`` directory.
#. Setup the filesystem layout to mirror the one :doc:`described in lab 1.3</class1/module1/lab03>`.
#. Add a ``bigip`` host to the ansible inventory and give it an ``ansible_host``
   fact with the value ``10.1.1.4``
#. *Type* the following into the ``playbooks/site.yaml`` file.

  ::

   ---

   - name: An example prompting playbook
     hosts: server

     vars_prompt:
       - name: partition
         prompt: "Enter a partition name"
         default: "Common"

     tasks:
       - name: Print out your input
         debug:
           msg: "You provided the {{ partition }} partition for the 'partition' prompt"

Run this playbook, from the ``lab3.1`` directory like so

  ::

   $ ansible-playbook -i inventory/hosts playbooks/site.yaml

Discussion
----------

Prompting is a great way to get input from the user. It can function in both
an interactive, and non-interactive way. We will learn later about that
:doc:`1.3 Expected File Layout</class1/module3/lab06>`.

Prompts can also blot out the values that you provide, so they can be useful
insinuations where you prompt for a password. This removal of input is done
with the ``private`` keyword to the prompt,  such as

  ::

   vars_prompt:
     - name: "some_password"
       prompt: "Enter password"
       private: yes

By default, private-ness is disabled.

You may want to use this instead of storing the password credentials in the
playbook.

#. *Type* the following into the ``playbooks/site2.yaml`` file.

  ::

   ---

   - name: An example pool playbook
     hosts: bigip
     connection: local

     vars_prompt:
       - name: "username"
         prompt: "Enter BIG-IP username"
         private: yes
       - name: "password"
         prompt: "Enter BIG-IP password"
         private: yes

     tasks:
       - name: Create web servers pool
         bigip_pool:
           name: web-servers
           lb_method: ratio-member
           password: "{{ password }}"
           server: 10.1.1.4
           user: "{{ username }}"
           validate_certs: no

Run this playbook, from the ``lab3.1`` directory like so

  ::

   $ ansible-playbook -i inventory/hosts playbooks/site2.yaml