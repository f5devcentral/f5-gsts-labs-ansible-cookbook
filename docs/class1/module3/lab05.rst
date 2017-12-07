Stepping through a playbook
===========================

Problem
-------

You need to step through each task because, by default, Ansible will fire off tasks
as fast as possible

Solution
--------

Use the ``--step`` argument of ``ansible-playbook``

#. Create a ``lab3.5`` directory in the ``labs`` directory.
#. Setup the filesystem layout to mirror the one :doc:`described in lab 1.3</class1/module1/lab03>`.
#. Add a ``bigip`` host to the ansible inventory and give it an ``ansible_host``
   fact with the value ``10.1.1.4``
#. *Type* the following into the ``playbooks/site.yaml`` file.

 ::

   ---

   - name: An example stepped playbook
     hosts: bigip
     connection: local

     environment:
       F5_SERVER: "{{ ansible_host }}"
       F5_USER: admin
       F5_PASSWORD: admin
       F5_SERVER_PORT: 443
       F5_VALIDATE_CERTS: no

     vars:
       send_string1: "GET /hr\r\n"
       monitor_name: "monitor2"

     tasks:
       - name: Create HTTP Monitor
         bigip_monitor_http:
           name: "{{ monitor_name }}"
           send: "{{ send_string1 }}"
         register: result

       - name: Assert Create HTTP Monitor
         assert:
           that:
             - result is changed
             - result.send == send_string1

       - name: Create HTTP Monitor - Idempotent check
         bigip_monitor_http:
           name: "{{ monitor_name }}"
           send: "{{ send_string1 }}"
         register: result

       - name: Assert Create HTTP Monitor - Idempotent check
         assert:
           that:
             - result is not changed

       - name: Remove HTTP Monitor
         bigip_monitor_http:
           name: "{{ monitor_name }}"
           state: absent
         register: result

You can see that we have 5 Tasks in this Playbook.

You have this test playbook, but you are not sure if they Tasks are actually doing
their work because the last Task removes the monitor. How do you check that 1 actually
changed the remote device? Sure, it may report changed, but did it *really* change?

You can do this by specifying the ``—-step`` argument to your Playbook.

  ::

   $ ansible-playbook -i inventory/hosts playbooks/site.yaml --step

The Play will run, but will Ansible will prompt you to either do the Task, Skip the
Task, or Continue on with all Tasks.

For example,

  ::

   $ ansible-playbook -i inventory/hosts playbooks/site.yaml --step

   PLAY [An example partition playbook] ****************************************************************************************************
   Perform task: TASK: Gathering Facts (N)o/(y)es/(c)ontinue: y

   Perform task: TASK: Gathering Facts (N)o/(y)es/(c)ontinue: ***********************************************************************************

   TASK [Gathering Facts] ***********************************************************************************************************************
   ok: [bigip1]
   Perform task: TASK: Create HTTP Monitor (N)o/(y)es/(c)ontinue:
   ^C

   $

Discussion
----------

Stepping is something I use frequently when I am writing a Playbook initially.
Between each step, Ansible will pause indefinitely and let you do something
out-of-band of the Playbook.

Often, I will do a task, then do either a series of debug work, or configuration
validation. For example, if I am using a new module, did the module actually
change my BIG-IP as I expected it would?

For debugging, I can pause right before a Task and make sure that,

* the device is indeed ready for my config
* any log files I am going to tail are empty so I don’t need to go look through them
* Any debug-level logging is configured on any remote devices
* etc

I can then run the Task, and proceed with the other future Tasks as needed. Once
I am ready to quit, I can ``ctrl+c`` the Playbook to stop all execution. Or, I can
press ``c`` to tell Ansible to proceed on with the entire rest of the Playbook.


