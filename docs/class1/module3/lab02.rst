Keeping secrets secret
======================

Problem
-------

You need to store passwords for use in Ansible

Solution
--------

Use ``ansible-vault``.

The `ansible-vault` command has three subcommands that are frequently used.

* create
* edit

Creating
````````

Use ``create`` to create the initial files that will be vault encrypted.
When you use the ``create`` subcommand, Vault will prompt you for a password.
It will then open up a text editor for you to write data to it. Data of any
form can be written, but text is usually the format that is used.

  ::

   $ ansible-vault create foo.bar
   New Vault password:
   Confirm New Vault password:
   $

When you save and quit the editor, the file will automatically be encrypted
for you. You can look at the encrypted file by ``cat``’ing it.

  ::

   $ cat foo.bar
   $ANSIBLE_VAULT;1.1;AES256
   3136653738353561303430646162386631613739306236386538396637326631383930623232663633306433633865343636393630376136303463396435
   38390a32373037313030653365613963643237643033663164376264313637
   61636134633863356536386133383065376533643864356362653737396632
   33373531650a39643034336463326138653439633637643033363735383665
   64313134613337
   $

Editing
```````

You may edit an existing Vault file by using a similar command

  ::

   $ ansible-vault edit foo.bar
   Vault password:

This time you will be asked for the password so that you can decrypt the file.

Discussion
----------

Vault is a tool that comes pre-installed with Ansible. It is a decent way to
protect data that is **not publicly available**. If you want to make data publicly
available, it is recommended that you use a technology like GPG.

Vault requires that a password be specified so that it can decrypt files.
That password can either be specified on the CLI or in a file.

It is recommended that for automation, this information is stored in a file.

If you store the password in a file, you can provide this file with the
``--vault-password-file`` argument to the ``ansible-vault`` command. This file does
not need to be static though. It can also be a script that gets the password
dynamically. For instance, if you stored the password itself in a organization
wide password-manager.