Starting the playbook at a specific task
========================================

Problem
-------

You need to start at a specific task in a playbook

Solution
--------

Use the ``--start-at-task`` argument of ``ansible-playbook``

#. Create a ``lab3.4`` directory in the ``labs`` directory.
#. Setup the filesystem layout to mirror the one :doc:`described in lab 1.3</class1/module1/lab03>`.
#. Add a ``bigip`` host to the ansible inventory and give it an ``ansible_host``
   fact with the value ``10.1.1.4``
#. *Type* the following into the ``playbooks/site.yaml`` file.

 ::

   ---

   - name: An example start-at playbook
     hosts: bigip
     connection: local

     environment:
       F5_SERVER: "{{ ansible_host }}"
       F5_USER: admin
       F5_PASSWORD: admin
       F5_SERVER_PORT: 443
       F5_VALIDATE_CERTS: no

     vars:
       send_string1: "GET /bizdev\r\n"
       monitor_name: "monitor1"

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

You can see that we have 4 Tasks in this Playbook.

You can run this Playbook once and it will do its thing. Then, assume that you
want to run the playbook again, but you want to start at the
*Create HTTP Monitor - Idempotent check* Task.

You can do this by specifying the Task name to the ``-—start-at-task`` argument.

  ::

   $ ansible-playbook -i inventory/hosts playbooks/site.yaml --start-at-task "Create HTTP Monitor - Idempotent check"

The Play will run, but will start at the third Task this time.

But there's an error that's raised. Why?

The answer, is because you started at the task which is intended to be the idempotent
check. Run the playbook again. Does the result change?

Discussion
----------

This argument is extremely valuable when it comes to debugging or running specific
blocks of a Playbook over.

There are certain things that you need to be aware of when using this argument though.

1. It will **not** run any prior tasks. Therefore, if you will start at (or have
   a future) Task that relies on some information from *before* the Task you are
   starting it, it will *not* be available. This will cause your Play to fail when it
   reaches the Task that needs this information
2. If you have multiple Tasks with the same name, the **first Task found** is the one
   that will be used.
3. **ALWAYS NAME YOUR TASKS!!1!!1!!!!!1** if you do not, it makes it incredibly
   difficult to start-at them in the future.
4. If the Task you are starting at is in a role, prefix the role name to the task
   followed by spacing and a colon. For example,
   ``—start-at-task "role1 : This is my roles task"``

Despite the constraints, this is a go-to feature that you will use all the time.
Remember it.
