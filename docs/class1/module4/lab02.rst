Save and view remote module execution code
==========================================

Problem
-------

You need to get the actual contents of a module that are run on the remote machine

Solution
--------

The solution to this problem is a series of steps that can be near impossible to
guess at. Let’s follow these steps to show you.

First, set the ``ANSIBLE_KEEP_REMOTE_FILES`` variable to ``1`` when you run a playbook.
Additionally, run the playbook with ``-vvv``. Using the playbook in
**lab4.2/playbooks/site.yaml** run the following command,

  ::

   $ ANSIBLE_KEEP_REMOTE_FILES=1 ansible-playbook -i inventory/hosts playbooks/site.yaml -vvv

After the playbook has finished execution, note the location of the module file
that was copied to the remote machine.

The module file is buried in the verbose output that the playbook generates.
Refer to the image below for an example.

|image1|

With this file found, we can ssh to the remote host in which we were running
this playbook on; ``server``

 ::

   $ ssh 10.1.1.6

and ``ls`` the file to make sure it exists

  ::

   $ ls -l /root/.ansible/tmp/ansible-tmp-1512367718.13-215224110025969/apt.py
   -rwx------ 1 root root 102974 Dec  4 06:08 /root/.ansible/tmp/ansible-tmp-1512367718.13-215224110025969/apt.py
   $

This file is a copy of the module and the libraries that it includes from
Ansible. It can be extracted with the ``explode`` argument

  ::

   $ /root/.ansible/tmp/ansible-tmp-1512367718.13-215224110025969/apt.py explode
   Module expanded into:
   /root/.ansible/tmp/ansible-tmp-1512367718.13-215224110025969/debug_dir
   $

It provides you with the directory where the content of the module was extracted to.

  ::

   $ ls -l
   total 48
   drwxr-xr-x 3 root root  4096 Dec  4 06:13 ansible
   -rw-r--r-- 1 root root 38495 Dec  4 06:13 ansible_module_apt.py
   -rw-r--r-- 1 root root   441 Dec  4 06:13 args
   $

The file named ``ansible_module_apt.py`` is the copy of module used in your
task. You can edit it directly and re-run the changed module and associated
files by using the `execute` argument to the same script you provided the
``explode`` argument to.

  ::

   $ /root/.ansible/tmp/ansible-tmp-1512367718.13-215224110025969/apt.py execute

The module will be run as if it were being run directly from the Ansible controller.

Discussion
----------

The method you’ve just learned is used extensively in the beginning stages of
how to debug modules. Even to this day I use it for extreme cases where I am
unable to diagnose a problem and need to execute the exact module code on a
remote machine.

This method requires no remote debuggers (like may be used in typical module
development or debugging) and it’s a rather straight-forward method once you
experience the usage pattern.

* ANSIBLE_KEEP_REMOTE_FILES
* /path/to/module.py explode
* change directory and edit
* /path/to/module.py execute

The reason that we need to do the explode part in particular is because
Ansible compresses the files that are part of the module, before it sends
it to the remote host. This sacrifices some CPU time on the Ansible controller
for what can often be a longer time transporting data over the network.

You can actually look at the compressed form if you ``less`` the file,

  ::

   $ less /root/.ansible/tmp/ansible-tmp-1512367718.13-215224110025969/apt.py

It will produce the self-extracting script; a large portion of which will be
the compressed module data

|image2|

Near the bottom of the self-extractor is also a blurb about how to use the
code should you get hung up. Here is an excerpt

|image3|

There are three commands, but only two that are frequently used, they are

* ``extract``
* ``execute``
* ``excommunicate`` (almost never used)

One last thing. It is not recommended that you run **all** your playbook with
``ANSIBLE_KEEP_REMOTE_FILES`` **all** the time. This is because keeping these
remote files causes a number of temporary files to build up on the remote host.

This can lead to disk space errors, filesystem errors, and even Ansible errors
if too many temp files exist (name collisions can happen for instance).

So it is best that you reserve the usage of this method for the times when you
need to do serious squirrel levels of debugging in either your own code, or the
code of others.

.. |image1| image:: /_static/class1/lab4.2.1.png
   :height: 4in
   :width: 6in
.. |image2| image:: /_static/class1/lab4.2.2.png
   :height: 4in
   :width: 6in
.. |image3| image:: /_static/class1/lab4.2.3.png
   :height: 7in
   :width: 6in