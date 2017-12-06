Sending arguments to your playbook
==================================

Problem
-------

You need to specify “vars” values automatically, such as via a command line.

Solution
--------

Use the ``-e``, or ``--extra-vars`` argument of ``ansible-playbook``

Remember the Playbook we had back in :doc:`Lab 3.1</class1/module3/lab01>`?
That Playbook prompted us for variables every time we ran it. Now we want to
run the same playbook without getting those prompts.

We can supply the prompt variable names, and their values, on the command line.

#. Change into the ``lab3.1`` directory.

Run this playbook, from the ``lab3.1`` directory like so

  ::

   $ ansible-playbook -i inventory/hosts playbooks/site.yaml -e "username=admin password=admin"

Discussion
----------

This method of specifying values is not reserved for credentials.

In most cases, it **should not** be used for credentials in fact. This is because
the Ansible command (including the extra arguments) will show in the running
process list of your Ansible controller.

The more common situations are when you are prompting for specific configuration
related to something on your network. For example, your Playbook may be flexible
enough to take a given ``region`` or ``cell``.

This would look like the following

  ::

   $ ansible-playbook -i inventory/hosts bootstrap.yaml -e "region=ord cell=c0006"

The Playbook would not need to change, but you could continually provide values to
variables in the Playbook to keep from writing them into the actual Playbook itself.
