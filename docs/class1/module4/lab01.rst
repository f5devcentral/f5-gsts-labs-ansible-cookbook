Enable verbose debugging
========================

Problem
-------

You want to get more context about what is happening when a Playbook runs,
because right now you have none

Solution
--------

Provide the ``-vvvv`` argument to the ``ansible-playbook`` command.

Enabling verbose output can be done as follows,

#. Change into the ``lab4.1`` directory in the ``labs`` directory.

  ::

   $ ansible-playbook -i inventory/hosts playbooks/site.yaml -vvvv

Running this will output more output that you would normally get. This
playbook includes an artificial module with an error message that would not
normally be displayed if you had not included the verbose output.

This is normal output

  ::

   TASK [Raises an error] ***************************************************
   An exception occurred during task execution. To see the full traceback, use
   -vvv. The error was: Exception: An error occurred
   fatal: [localhost]: FAILED! => {"changed": false, "module_stderr": "Traceback
   (most recent call last):\n  File \"/Users/trupp/.ansible/tmp/ansible-tmp-1512
   284216.7-97617236630854/foo41.py\", line 24, in <module>\n    a1()\n  File
   \"/Users/trupp/.ansible/tmp/ansible-tmp-1512284216.7-97617236630854/foo41.py\",
   line 13, in a1\n    b1()\n  File \"/Users/trupp/.ansible/tmp/ansible-tmp-15122
   84216.7-97617236630854/foo41.py\", line 16, in b1\n    c1()\n  File \"/Users/
   trupp/.ansible/tmp/ansible-tmp-1512284216.7-97617236630854/foo41.py\", line 19,
   in c1\n    d1()\n  File \"/Users/trupp/.ansible/tmp/ansible-tmp-1512284216.7-9
   7617236630854/foo41.py\", line 22, in d1\n    raise Exception(\"An error occur
   red\")\nException: An error occurred\n", "module_stdout": "", "msg": "MODULE
   FAILURE", "rc": 0}

This is verbose output

  ::

   TASK [Raises an error] ****************************************************
   task path: /Users/trupp/src/f5-gsts-labs-ansible-cookbook/docs/labs/playbooks/lab4.1.yaml:8
   Using module file /Users/trupp/src/f5-gsts-labs-ansible-cookbook/docs/labs/library/foo41.py
   <localhost> ESTABLISH LOCAL CONNECTION FOR USER: trupp
   <localhost> EXEC /bin/sh -c 'echo ~ && sleep 0'
   <localhost> EXEC /bin/sh -c '( umask 77 && mkdir -p "` echo /Users/trupp/
     .ansible/tmp/ansible-tmp-1512284240.61-66631414390058 `" && echo ansible-
     tmp-1512284240.61-66631414390058="` echo /Users/trupp/.ansible/tmp/ansibl
     e-tmp-1512284240.61-66631414390058 `" ) && sleep 0'
   <localhost> PUT /var/folders/jc/9d1188j962931rhqrlm4173w5j5m45/T/tmpOT27vx TO
     /Users/trupp/.ansible/tmp/ansible-tmp-1512284240.61-66631414390058/foo41.py
   <localhost> PUT /var/folders/jc/9d1188j962931rhqrlm4173w5j5m45/T/tmpZwW0ZP TO
     /Users/trupp/.ansible/tmp/ansible-tmp-1512284240.61-66631414390058/args
   <localhost> EXEC /bin/sh -c 'chmod u+x /Users/trupp/.ansible/tmp/ansible-tmp-
     1512284240.61-66631414390058/ /Users/trupp/.ansible/tmp/ansible-tmp-1512284
     240.61-66631414390058/foo41.py /Users/trupp/.ansible/tmp/ansible-tmp-1512
     284240.61-66631414390058/args && sleep 0'
   <localhost> EXEC /bin/sh -c '/usr/bin/python /Users/trupp/.ansible/tmp/ansi
     ble-tmp-1512284240.61-66631414390058/foo41.py /Users/trupp/.ansible/tmp/a
     nsible-tmp-1512284240.61-66631414390058/args; rm -rf "/Users/trupp/.ansib
     le/tmp/ansible-tmp-1512284240.61-66631414390058/" > /dev/null 2>&1 && sle
     ep 0'
   The full traceback is:
   Traceback (most recent call last):
     File "/Users/trupp/.ansible/tmp/ansible-tmp-1512284240.61-66631414390058/foo41.py", line 24, in <module>
       a1()
     File "/Users/trupp/.ansible/tmp/ansible-tmp-1512284240.61-66631414390058/foo41.py", line 13, in a1
       b1()
     File "/Users/trupp/.ansible/tmp/ansible-tmp-1512284240.61-66631414390058/foo41.py", line 16, in b1
       c1()
     File "/Users/trupp/.ansible/tmp/ansible-tmp-1512284240.61-66631414390058/foo41.py", line 19, in c1
       d1()
     File "/Users/trupp/.ansible/tmp/ansible-tmp-1512284240.61-66631414390058/foo41.py", line 22, in d1
       raise Exception("An error occurred")
   Exception: An error occurred

   fatal: [localhost]: FAILED! => {
       "changed": false,
       "module_stderr": "Traceback (most recent call last):\n  File \"/Users/trupp/
         .ansible/tmp/ansible-tmp-1512284240.61-66631414390058/foo41.py\", line 24,
         in <module>\n    a1()\n  File \"/Users/trupp/.ansible/tmp/ansible-tmp-1512
         284240.61-66631414390058/foo41.py\", line 13, in a1\n    b1()\n  File \"/U
         sers/trupp/.ansible/tmp/ansible-tmp-1512284240.61-66631414390058/foo41.py\
         ", line 16, in b1\n    c1()\n  File \"/Users/trupp/.ansible/tmp/ansible-tm
         p-1512284240.61-66631414390058/foo41.py\", line 19, in c1\n    d1()\n  Fil
         e \"/Users/trupp/.ansible/tmp/ansible-tmp-1512284240.61-66631414390058/foo4
         1.py\", line 22, in d1\n    raise Exception(\"An error occurred\")\nExcepti
         on: An error occurred\n",
       "module_stdout": "",
       "msg": "MODULE FAILURE",
       "rc": 0
   }

Discussion
----------

I don’t take my chances when running playbooks. I always use verbose logging.

You will find over time, that if you do not do this, that you will miss out on
some of the more critical information that may be required to track down a problem.

The verbose information that is shown is typically the first step in debugging a
problem, and the F5 Ansible developers will want it from you when you report a problem.

Verbose output includes several key pieces of information that will be used to
debug problems even further. These include

* The connection information
* Delegation information
* Remote playbook execution files
* Structured failure output

We will discuss the third bullet in more detail in a lab in the next lab.
