Dealing with "authorization failed" errors
==========================================

Problem
-------

Your playbook is failing with an error about "F5 Authorization failed"

Solution
--------

Either your password is wrong. But it isn’t! Yes...for the last time...it is.

Or,

Your remote authentication is configured (on BIG-IP) incorrectly.

Or,

The role of the user that you are using with the Ansible module is not Administrator
or an equivalent.

Ensure that your password is correct. There is a specific command that you should
ensure runs without error, it is

  ::

   $ curl -k -u admin:admin https://10.1.1.4/mgmt/tm/sys | jq .

Replace ``admin:admin`` with your ``user``, and ``password`` combination. If the
above command does not succeed, then it will not be possible for the F5 Ansible
module to succeed. On some other versions of BIG-IP it was not possible for this
to succeed.

A successful output will look like the following

|image1|

In addition to incorrect passwords, ensure that your remote authentication is correct.
You should see entries in ``/var/log/secure``.

Finally, the only supported role for the F5 Ansible modules is ``Administrator``. No module
is expected to work without this role being assigned to them.

Discussion
----------
Authentication can be a gnarly beast to debug because there are *so* many possible
reasons it could not be working.

By far, the two most common reasons are

* People are not providing the right password
* Remote authentication is misconfigured on BIG-IP

Understandably, people will often tell you that “of course my password is correct”.
They will be wrong. 9 times out of 10, they will have either typed in the wrong
password, or targeted the wrong BIG-IP (the BIG-IPs having different passwords).

If this is not the case, then confirm that their remote authentication is configured
correctly. BIG-IP will log authentication successes to ``/var/log/secure``.  Therefore,
if there are no entries in that file when a user runs an Ansible playbook with a
remote auth user, that could be a problem.

The final thing that is often missed (with remote authentication in particular) is the
assignment of BIG-IP roles to the remote-auth role. TACACS is notorious for this.
Just because you have remote auth configured does not necessarily mean that all is well.
You must also ensure that the remote users are associated with the local Administrator
role.

Too often this is overlooked.

On later versions of BIG-IP, you can find the menu that needs to be configured in
**System > Users > Remote Role Groups**. See the image below.

|image2|

If these are not configured properly, then you’ll be dead in the water. Figure your
remote authentication out.

This is almost never an Ansible problem. 99.999% of the time it is a user problem.

.. |image1| image:: /_static/class1/lab4.7.1.png
   :height: 3in
   :width: 6in
.. |image2| image:: /_static/class1/lab4.7.2.png
   :height: 7in
   :width: 6in