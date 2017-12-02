Creating an HTTP service from the HTTP iApp
===========================================

Problem
-------

You need to create a service from the HTTP iApp

Solution
--------

Use the ``bigip_iapp_service`` module. ::

   - name: An example iApp service playbook
     hosts: big-ip01
     connection: local

     vars:
       validate_certs: no
       username: admin
       password: admin

     tasks:
       - name: Add the iApp
         bigip_iapp_service:
           name: tests
           template: f5.http
           password: "{{ password }}"
           server: 10.1.1.4
           validate_certs: "{{ validate_certs }}"
           state: present
           user: "{{ username }}"
           parameters:
             variables:
               - name: var__vs_address
                 value: 1.1.1.1
               - name: pm__apache_servers_for_http
                 value: 2.2.2.1:80
               - name: pm__apache_servers_for_https
                 value: 2.2.2.2:80
             lists:
               - name: irules__irules
                 value:
                   - foo
                   - bar
             tables:
               - name: basic__snatpool_members
               - name: net__snatpool_members
               - name: optimizations__hosts
               - name: pool__hosts
                 columnNames:
                   - name
                 rows:
                   - row:
                       - internal.company.bar
               - name: pool__members
                 columnNames:
                   - addr
                   - port
                   - connection_limit
                 rows:
                   - row:
                       - "none"
                       - 80
                       - 0
               - name: server_pools__servers

Discussion
----------

The ``bigip_iapp_service`` module can manage the iApp services that are
on the remote BIG-IP.

The easiest way to provide data to this module is in the form of a content
``lookup``, providing the path to a file containing the ``parameters`` argument.

To use that approach would require a JSON file and a specific format of Task in
your Playbook. An example is below. ::

       - name: Add the iApp
         bigip_iapp_service:
           name: tests
           template: f5.http
           password: "{{ password }}"
           server: 10.1.1.4
           validate_certs: "{{ validate_certs }}"
           state: present
           user: "{{ username }}"
           parameters: "{{ lookup('file', '../files/http-iapp-parameters.json') }}"

Observe how we changed the parameters to use a lookup instead of providing the
YAML format.

The syntax for a lookup is similar to normal Ansible variables, in that it is wrapped
in ``{{`` and ``}}``. It differs though in its use a the following command.

* ``lookup('file', '/path/to/file')``

You can read this in the same way you might read a function in a programming language.

The ``lookup`` word is the same of a method that Ansible makes available to you. Next,
is the word ``file`` wraped in quotes. This is a *type* of lookup. There are many types
of lookups that you can use. Finally is the path on the filesystem that you want to look
up. That is in the ``/path/to/file/`` value; also wrapped in quotes.

The parentheses ``(`` and ``)`` are also important, and required, in the places that
you see them.

Also, yes, in the solution's example, the ``parameters`` argument really looks like
that; the iApp service data structures them self are responsible for that. We
(F5 Ansible modules) may be able to improve upon this in the future.