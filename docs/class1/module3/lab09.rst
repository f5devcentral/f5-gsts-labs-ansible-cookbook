Running in a virtualenv, and the associated problems
====================================================

Problem
-------

You need to run Ansible from a Python virtualenv environment

Solution
--------

This is possible, but it requires a keen understanding of how Ansible works, as well as a change to the host_vars for a single host
(or group_vars if you want to apply this to multiple hosts)

#. Change into the ``lab3.9`` directory in the ``labs`` directory.
#. Setup the filesystem layout to mirror the one :doc:`described in lab 1.3</class1/module1/lab03>`.
#. Change the ``playbooks/site.yaml`` file to resemble the following.
#. Add a ``bigip`` host to the ansible inventory and give it an ``ansible_host``
   fact with the value ``10.1.1.4``

  ::

   ---

   - name: An example command playbook
     hosts: bigip
     connection: local

     environment:
       F5_SERVER: "{{ ansible_host }}"
       F5_USER: admin
       F5_PASSWORD: admin
       F5_SERVER_PORT: 443
       F5_VALIDATE_CERTS: no

     tasks:
       - name: Create a datagroup using tmsh
         bigip_command:
           commands: "tmsh show sys version"

Next, we will uninstall our f5-sdk package from the system. Most people consider
this to be an OK thing to do because, after all, they will be running Ansible
from a virtualenv.

  ::

   pip uninstall --yes f5-sdk bigsuds

There is a virtualenv pre-installed on your Ansible Controller. You can activate
it with the following command

  ::

   $ source /.virtualenvs/lab3.9/bin/activate

You will know that you are in the virtualenv, because your prompt will change.
It should look similar to this, where the word `ansible` prefixes the CLI prompt.

  ::

   (lab3.9) $

You can verify that the necessary `pip` libraries are installed with the following
command.

  ::

   $ pip freeze

You should see in this list, an entry for ``f5-sdk``.

Let’s now run the Ansible Playbook.

  ::

   $ ansible-playbook -i inventory/hosts playbooks/site.yaml

If your playbook fails, that is to be expected.

Now, change the ``inventory/hosts`` file and add the following fact to the `bigip` line.

  ::

   ansible_python_interpreter=/.virtualenvs/lab3.9/bin/python

Re-run the ``ansible-playbook`` command from above.

If your playbook succeeds, that is expected. Proceed to the Discussion for a deeper
answer as to what is happening.

Be sure to re-install the F5 Ansible dependencies that you removed as we will use them
in future labs

  ::

  $ pip install f5-sdk bigsuds

Discussion
----------

Why does it fail the first time? The answer is because Ansible is **not** running
your module in the virtualenv. It’s running it on the system’s Python.

That doesn’t make sense though, it should be running be running in the virtualenv.
Wrong.

A brief segue is necessary
``````````````````````````

Ansible’s default behavior is that it **always** SSH’s to the remote host. Always.
Even when ``connection: local`` is set, it is running...in a sense...on the “remote” host;
only this time, localhost is considered the remote host.

Setting ``connection: local`` only eliminates the SSH protocol, it does **not**, however,
eliminate the fact that Ansible is going to always run your module using
``/usr/bin/python``.

By default, modules point at ``/usr/bin/python``. Period.

So Ansible itself runs just fine in a virtualenv. The problem is that when it
communicates with the "remote" host, the **module** is going to run with ``/usr/bin/python``.
That means that the F5 dependency libraries are also going to be looked up according
to ``/usr/bin/python``. If you installed your dependencies in a virtualenv, that
virtualenv’s python is not ``/usr/bin/python``.

This is why you **must** set the ``ansible_python_interpreter`` for any hosts, or groups
of hosts, where the python interpreter differs. We did this in our solution for a single
host when we changed the ``inventory/hosts`` file. We could have also created a file
at ``inventory/group_vars/all.yaml`` and those facts would apply to **all** hosts in your
playbook.
