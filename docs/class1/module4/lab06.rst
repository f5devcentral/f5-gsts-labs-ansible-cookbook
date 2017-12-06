Dealing with “bigsuds/f5-sdk not found” errors
==============================================

Problem
-------

Your playbook is failing with an error about being "unable to find bigsuds/f5-sdk",
but you’re SURE they are installed

Solution
--------

There are three potential causes for this that we’ll cover. They are

* They’re not installed in the right spot
* You’re not using connection local
* You’re not using delegation

Wrong installation location
```````````````````````````

If you are using a virtualenv, or a system that does not have python found at
``/usr/bin/python``, you *must* set the python interpreter of that system for Ansible.

This might be ``/usr/bin/python3`` or the path to the virtualenv python like
``ansible_python_interpreter=/.virtualenvs/lab4.6/bin/python``

See the discussion below for more information regarding this issue.

Not using connection local
``````````````````````````

You have not specified ``connection: local``. Therefore, all remote hosts will be connected to over SSH. Nine times out of ten the “not found” error is being raised because Ansible is connecting to a remote BIG-IP and the F5 module dependencies are not installed on the BIG-IP

*The F5 Ansible modules can not be installed on a BIG-IP*

Use ``connection: local`` for the play, or, ``delegate_to: localhost``
**for each BIG-IP task**

Not using delegation
````````````````````

See the solution above as the reason and solution are the same, only this time
you are missing ``delegate_to: localhost`` instead of ``connection: local``

Discussion
----------

In an earlier lab we had, we learned that Ansible considers all your hosts to be
remote. This includes when you running it in a virtualenv or use ``connection: local``.

This "wrong installation location" problem rears its head primarily when you run
Ansible in a virtualenv.

As a general rule of thumb, don’t do that unless you know what you’re doing. If
you’re reading this lab, you probably don’t know what you’re doing.

To experience the error, we’ll use a contrived example with two virtualenvs; one
with the dependencies installed, one without. These labs can be found in the **lab4.6**
directory.

We have configured our hosts to reference two different python interpreters.
The ``broken`` host, references a python interpreter that is intended to mimic your
non-virtualenv remote system (I know its referencing a virtualenv, imagine with me here).

The ``working`` python interpreter is intended to mimic the virtualenv that you
have installed Ansible in.

Change into the working virtualenv.

  ::

   $ workon lab4.6

When you are in the virtualenv and the following shows ``f5-sdk``,

  ::

   (lab4.6) $ pip freeze | grep f5-sdk
   f5-sdk==3.0.5
   $

It is irrelevant. It is what is **in the remote system’s python installation that matters**
because that is the python that is invoked by default when Ansible connects to a machine.

Let’s run the **lab4.6/playbooks/site.yaml** playbook now

  ::

   $ ansible-playbook -i inventory/hosts playbooks/site.yaml

It seems the playbook fails (output truncated)

  ::

   TASK [Create a pool] ****************************************************************************************************************
   An exception occurred during task execution. To see the full traceback, use -vvv. The error was: ImportError: No module named netaddr
   fatal: [broken]: FAILED! => {"changed": false, "module_stderr": "Traceback (most recent call last):\n  File \"/tmp/ansible__3fdUX/ans
           to retry, use: --limit @/root/f5-gsts-labs-ansible-cookbook/labs/lab4.6/playbooks/site.retry

To fix this, change the ``ansible_python_interpreter`` line in ``inventory/hosts``
file to read

* ``ansible_python_interpreter=/.virtualenvs/lab4.6/bin/python``

Let's re-run the playbook now

  ::

   $ ansible-playbook -i inventory/hosts playbooks/site.yaml

Take a moment to review the images below for a better understanding of what Ansible
is doing.

This is how Ansible normally works

|image1|

In the virtualenv situation above, what we had instead, is that the Ansible
client had the F5 SDK installed in one virtualenv, but the remote host used a different
virtualenv. Therefore, we had a similar situation as the picture above, but using
virtualenv instead

|image2|

As you can see, we have the F5 SDK installed in the venv we were using, but **not** in
the venv that the remote host was configured for.

The same is implied when you are only using a single venv and the remote host specifies
nothing. In that case, you will need the dependencies installed in the **system** python.

|image3|


.. |image1| image:: /_static/class1/lab4.6.1.png
   :height: 4in
   :width: 6in
.. |image2| image:: /_static/class1/lab4.6.2.png
   :height: 4in
   :width: 6in
.. |image3| image:: /_static/class1/lab4.6.3.png
   :height: 4in
   :width: 6in