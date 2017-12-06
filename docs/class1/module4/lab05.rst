Enable debug output
===================

Problem
-------

You want to see more complete debugging when running playbooks

Solution
--------

Set the environment variable ``ANSIBLE_DEBUG`` to `1` when you run the
``ansible-playbook`` command.

#. Change into the ``lab4.5`` directory in the ``labs`` directory.

  ::

   $ ANSIBLE_DEBUG=1 ansible-playbook -i inventory/hosts playbooks/site.yaml

Running this will output *a lot* more output than even the verbose output gives you. None of the debug output is what you would normally get. This playbook is a contrived example, but illustrates debug’s output.

This is normal output

  ::

   $ ansible-playbook -i inventory/hosts playbooks/site.yaml

   PLAY [Labb 4.5] ***********************************************

   TASK [Gathering Facts] ****************************************
   ok: [localhost]

   TASK [Run a task] *********************************************
   ok: [localhost]

   TASK [Run a second task] **************************************
   skipping: [localhost]

   TASK [Run a third task] ***************************************
   ok: [localhost] => {
       "fact1": "foo"
   }

   PLAY RECAP ****************************************************
   localhost                  : ok=3    changed=0    unreachable=0    failed=0

This is verbose output (truncated for readability)

  ::

   $ ANSIBLE_DEBUG=1 ansible-playbook -i inventory/hosts playbooks/site.yaml
    88233 1512328569.77688: starting run
    88233 1512328569.87126: Added group all to inventory
    88233 1512328569.87134: Added group ungrouped to inventory
    88233 1512328569.87139: Group all now contains ungrouped
    88233 1512328569.87326: Loading InventoryModule 'host_list' from /Users/tru...
    88233 1512328569.87484: assigned :doc
    88233 1512328569.87490: assigned :plainexamples
    88233 1512328569.87513: Loading InventoryModule 'script' from /Users/trupp/...
    88233 1512328569.89141: assigned :doc
    88233 1512328569.89160: Loaded config def from plugin (inventory/script)
    88233 1512328569.89193: Loading InventoryModule 'yaml' from /Users/trupp/sr...
    88233 1512328569.89762: assigned :doc
    88233 1512328569.89769: assigned :plainexamples
    88233 1512328569.89780: Loaded config def from plugin (inventory/yaml)
    88233 1512328569.89823: Loading InventoryModule 'ini' from /Users/trupp/src...
    88233 1512328569.90388: assigned :doc
    88233 1512328569.90394: assigned :plainexamples
    88233 1512328569.90425: Loading InventoryModule 'auto' from /Users/trupp/sr...
    88233 1512328569.90644: assigned :doc
    88233 1512328569.90649: assigned :plainexamples
    88233 1512328569.90696: Examining possible inventory source: /Users/trupp/s...
    88233 1512328569.90705: Attempting to use plugin host_list (/Users/trupp/sr...
    88233 1512328569.90713: /Users/trupp/src/f5-gsts-labs-ansible-cookbook/docs...
    88233 1512328569.90717: Attempting to use plugin script (/Users/trupp/src/e...
    88233 1512328569.90729: /Users/trupp/src/f5-gsts-labs-ansible-cookbook/docs...
    88233 1512328569.90734: Attempting to use plugin yaml (/Users/trupp/src/env...
    88233 1512328569.90804: Loading data from /Users/trupp/src/f5-gsts-labs-ans...
    88233 1512328569.90854: /Users/trupp/src/f5-gsts-labs-ansible-cookbook/docs...
    88233 1512328569.90860: Attempting to use plugin ini (/Users/trupp/src/envs...
    88233 1512328569.90993: set inventory_file for localhost
    88233 1512328569.91004: set inventory_dir for localhost
    88233 1512328569.91009: Added host localhost to inventory
    88233 1512328569.91015: Added host localhost to group ungrouped
    88233 1512328569.91020: Reconcile groups and hosts in inventory.
    88233 1512328569.91025: Group all now contains localhost
    88233 1512328569.91166: Loading CacheModule 'memory' from /Users/trupp/src/...
    88233 1512328569.93963: Loading data from /Users/trupp/src/f5-gsts-labs-ans...
    88233 1512328570.14469: Loading CallbackModule 'default' from /Users/trupp/...
    88233 1512328570.14924: assigned :doc
    88233 1512328570.14989: Loading CallbackModule 'actionable' from /Users/tru...
    88233 1512328570.15173: assigned :doc
    88233 1512328570.15194: Loading CallbackModule 'context_demo' from /Users/t...
    88233 1512328570.15406: assigned :doc
    88233 1512328570.15427: Loading CallbackModule 'debug' from /Users/trupp/sr...
    88233 1512328570.15599: assigned :doc
    88233 1512328570.15609: Loading CallbackModule 'default' from /Users/trupp/...
    88233 1512328570.15980: assigned :doc
    88233 1512328570.16029: Loading CallbackModule 'dense' from /Users/trupp/sr...
    88233 1512328570.16451: assigned :doc
    88233 1512328570.20526: Loading CallbackModule 'foreman' from /Users/trupp/...
    88233 1512328570.21163: assigned :doc
    88233 1512328570.21185: Loaded config def from plugin (callback/foreman)
    88233 1512328570.21223: Loading CallbackModule 'full_skip' from /Users/trup...
    88233 1512328570.21458: assigned :doc
    88233 1512328570.22018: Loading CallbackModule 'hipchat' from /Users/trupp/...
    88233 1512328570.22699: assigned :doc
    88233 1512328570.22725: Loaded config def from plugin (callback/hipchat)
    88233 1512328570.22780: Loading CallbackModule 'jabber' from /Users/trupp/s...
    88233 1512328570.23387: assigned :doc
    88233 1512328570.23440: Loaded config def from plugin (callback/jabber)
    88233 1512328570.23524: Loading CallbackModule 'json' from /Users/trupp/src...
    88233 1512328570.23921: assigned :doc
    88233 1512328570.24611: Loading CallbackModule 'junit' from /Users/trupp/sr...
    88233 1512328570.25312: assigned :doc
    88233 1512328570.25339: Loaded config def from plugin (callback/junit)
    88233 1512328570.25366: Loading CallbackModule 'log_plays' from /Users/trup...
    88233 1512328570.25624: assigned :doc
    88233 1512328570.25681: Loading CallbackModule 'logentries' from /Users/tru...
    88233 1512328570.27404: assigned :doc
    88233 1512328570.27414: assigned :plainexamples
    88233 1512328570.27440: Loaded config def from plugin (callback/logentries)
    88233 1512328570.27493: Loading CallbackModule 'logstash' from /Users/trupp...
    88233 1512328570.28007: assigned :doc
    88233 1512328570.28025: Loaded config def from plugin (callback/logstash)
    88233 1512328570.28143: Loading CallbackModule 'mail' from /Users/trupp/src...
    88233 1512328570.28534: assigned :doc
    88233 1512328570.28553: Loaded config def from plugin (callback/mail)
    88233 1512328570.28576: Loading CallbackModule 'minimal' from /Users/trupp/...
    88233 1512328570.28733: assigned :doc
    88233 1512328570.28762: Loading CallbackModule 'null' from /Users/trupp/src...
    88233 1512328570.28914: assigned :doc
    88233 1512328570.28943: Loading CallbackModule 'oneline' from /Users/trupp/...
    88233 1512328570.29117: assigned :doc
    88233 1512328570.29147: Loading CallbackModule 'osx_say' from /Users/trupp/...
    88233 1512328570.29348: assigned :doc
    88233 1512328570.29375: Loading CallbackModule 'profile_roles' from /Users/...
    88233 1512328570.29630: assigned :doc
    88233 1512328570.29702: Loading CallbackModule 'profile_tasks' from /Users/...
    88233 1512328570.30465: assigned :doc
    88233 1512328570.30476: assigned :plainexamples
    88233 1512328570.30505: Loaded config def from plugin (callback/profile_tasks)
    88233 1512328570.30542: Loading CallbackModule 'selective' from /Users/trup...
    88233 1512328570.31090: assigned :doc
    88233 1512328570.31097: assigned :plainexamples
    88233 1512328570.31118: Loaded config def from plugin (callback/selective)
    88233 1512328570.31139: Loading CallbackModule 'skippy' from /Users/trupp/s...
    88233 1512328570.31305: assigned :doc
    88233 1512328570.31328: Loading CallbackModule 'slack' from /Users/trupp/sr...
    88233 1512328570.32250: assigned :doc
    88233 1512328570.32289: Loaded config def from plugin (callback/slack)
    88233 1512328570.32337: Loading CallbackModule 'stderr' from /Users/trupp/s...
    88233 1512328570.32782: assigned :doc
    88233 1512328570.33061: Loading CallbackModule 'syslog_json' from /Users/tr...
    88233 1512328570.34292: assigned :doc
    88233 1512328570.34341: Loaded config def from plugin (callback/syslog_json)
    88233 1512328570.34432: Loading CallbackModule 'timer' from /Users/trupp/sr...
    88233 1512328570.34699: assigned :doc
    88233 1512328570.34755: Loading CallbackModule 'tree' from /Users/trupp/src...
    88233 1512328570.35199: assigned :doc
    88233 1512328570.35319: Loading CallbackModule 'unixy' from /Users/trupp/sr...
    88233 1512328570.35797: assigned :doc
    88233 1512328570.35953: Loading CallbackModule 'yaml' from /Users/trupp/src...
    88233 1512328570.36363: assigned :doc
    88233 1512328570.36411: in VariableManager get_vars()
    88233 1512328570.37284: Loading FilterModule 'core' from /Users/trupp/src/e...
    88233 1512328570.39222: Loading FilterModule 'ipaddr' from /Users/trupp/src...
    88233 1512328570.39913: Loading FilterModule 'json_query' from /Users/trupp...
    88233 1512328570.40022: Loading FilterModule 'mathstuff' from /Users/trupp/...
    88233 1512328570.40233: Loading FilterModule 'network' from /Users/trupp/sr...
    88233 1512328570.40287: Loading FilterModule 'urlsplit' from /Users/trupp/s...
    88233 1512328570.40499: Loading TestModule 'core' from /Users/trupp/src/env...
    88233 1512328570.40560: Loading TestModule 'files' from /Users/trupp/src/en...
    88233 1512328570.40642: Loading TestModule 'mathstuff' from /Users/trupp/sr...
    88233 1512328570.41209: done with get_vars()
    88233 1512328570.41286: in VariableManager get_vars()
    88233 1512328570.41373: Loading FilterModule 'core' from /Users/trupp/src/e...
    88233 1512328570.41384: Loading FilterModule 'ipaddr' from /Users/trupp/src...
    88233 1512328570.41394: Loading FilterModule 'json_query' from /Users/trupp...
    88233 1512328570.41402: Loading FilterModule 'mathstuff' from /Users/trupp/...
    88233 1512328570.41410: Loading FilterModule 'network' from /Users/trupp/sr...
    88233 1512328570.41418: Loading FilterModule 'urlsplit' from /Users/trupp/s...
    88233 1512328570.41479: Loading TestModule 'core' from /Users/trupp/src/env...
    88233 1512328570.41487: Loading TestModule 'files' from /Users/trupp/src/en...
    88233 1512328570.41500: Loading TestModule 'mathstuff' from /Users/trupp/sr...
    88233 1512328570.41917: done with get_vars()

   PLAY [Labb 4.5] ************************************************************
    88233 1512328570.43407: Loading StrategyModule 'linear' from /Users/trupp/s...
    88233 1512328570.43460: getting the remaining hosts for this loop
    88233 1512328570.43472: done getting the remaining hosts for this loop
    88233 1512328570.43483: building list of next tasks for hosts
    88233 1512328570.43491: getting the next task for host localhost
    88233 1512328570.43504: done getting next task for host localhost
    88233 1512328570.43514:  ^ task is: TASK: Gathering Facts
    88233 1512328570.43522:  ^ state is: HOST STATE: block=0, task=0, rescue=0,...
    88233 1512328570.43529: done building task lists
    88233 1512328570.43535: counting tasks in each state of execution
    88233 1512328570.43541: done counting tasks in each state of execution:
           num_setups: 1
           num_tasks: 0
           num_rescue: 0
           num_always: 0
    88233 1512328570.43545: advancing hosts in ITERATING_SETUP
    88233 1512328570.43549: starting to advance hosts
    88233 1512328570.43553: getting the next task for host localhost
    88233 1512328570.43558: done getting next task for host localhost
    88233 1512328570.43562:  ^ task is: TASK: Gathering Facts
    88233 1512328570.43566:  ^ state is: HOST STATE: block=0, task=0, rescue=0,...
    88233 1512328570.43571: done advancing hosts to next task
    88233 1512328570.43578: getting variables
    88233 1512328570.43583: in VariableManager get_vars()
    88233 1512328570.43621: Loading FilterModule 'core' from /Users/trupp/src/e...
    88233 1512328570.43630: Loading FilterModule 'ipaddr' from /Users/trupp/src...
    88233 1512328570.43641: Loading FilterModule 'json_query' from /Users/trupp...
    88233 1512328570.43650: Loading FilterModule 'mathstuff' from /Users/trupp/...
    88233 1512328570.43658: Loading FilterModule 'network' from /Users/trupp/sr...
    88233 1512328570.43667: Loading FilterModule 'urlsplit' from /Users/trupp/s...
    88233 1512328570.43696: Loading TestModule 'core' from /Users/trupp/src/env...
    88233 1512328570.43708: Loading TestModule 'files' from /Users/trupp/src/en...
    88233 1512328570.43716: Loading TestModule 'mathstuff' from /Users/trupp/sr...
    88233 1512328570.43867: Calling all_inventory to load vars for localhost
    88233 1512328570.43888: Calling groups_inventory to load vars for localhost
    88233 1512328570.43901: Calling all_plugins_inventory to load vars for localhost
    88233 1512328570.44240: Loading VarsModule 'host_group_vars' from /Users/tr...
    88233 1512328570.44275: Calling all_plugins_play to load vars for localhost
    88233 1512328570.44303: Loading VarsModule 'host_group_vars' from /Users/tr...
    88233 1512328570.44325: Calling groups_plugins_inventory to load vars for localhost
    88233 1512328570.44354: Loading VarsModule 'host_group_vars' from /Users/tr...
    88233 1512328570.44383: Calling groups_plugins_play to load vars for localhost
    88233 1512328570.46982: Loading VarsModule 'host_group_vars' from /Users/tr...
    88233 1512328570.47033: Loading VarsModule 'host_group_vars' from /Users/tr...
    88233 1512328570.47063: Loading VarsModule 'host_group_vars' from /Users/tr...
    88233 1512328570.47104: done with get_vars()
    88233 1512328570.47132: done getting variables
    88233 1512328570.47143: sending task start callback, copying the task so we...
    88233 1512328570.47154: done copying, going to template now
    88233 1512328570.47164: done templating
    88233 1512328570.47171: here goes the callback...

   TASK [Gathering Facts] *****************************************************
    88233 1512328570.47183: sending task start callback
    88233 1512328570.47190: entering _queue_task() for localhost/setup
    88233 1512328570.47339: worker is 1 (out of 1 available)
    88233 1512328570.47410: exiting _queue_task() for localhost/setup
    88233 1512328570.47435: done queuing things up, now waiting for results queue to drain
    88233 1512328570.47451: waiting for pending results...
    88247 1512328570.47777: running TaskExecutor() for localhost/TASK: Gathering Facts
    88247 1512328570.47883: in run() - task 8c85904d-91d6-70e5-2197-000000000011
    88247 1512328570.48303: calling self._execute()
    88247 1512328570.49597: Loading Connection 'local' from /Users/trupp/src/env...
    88247 1512328570.49687: Loading ShellModule 'csh' from /Users/trupp/src/envs...
    88247 1512328570.49787: Loading ShellModule 'fish' from /Users/trupp/src/env...
    88247 1512328570.49806: Loading ShellModule 'powershell' from /Users/trupp/s...
    88247 1512328570.49822: Loading ShellModule 'sh' from /Users/trupp/src/envs/...
    88247 1512328570.49917: Loading ShellModule 'sh' from /Users/trupp/src/envs/...
    88247 1512328570.50658: assigned :doc
    88247 1512328570.50814: Loading ActionModule 'normal' from /Users/trupp/src/...
    88247 1512328570.50831: starting attempt loop
    88247 1512328570.50838: running the handler
    88247 1512328570.50930: ANSIBALLZ: Using lock for setup
    88247 1512328570.50939: ANSIBALLZ: Acquiring lock
    88247 1512328570.50950: ANSIBALLZ: Lock acquired: 4534992464
    88247 1512328570.50962: ANSIBALLZ: Creating module
    88247 1512328570.85142: ANSIBALLZ: Writing module
    88247 1512328570.85214: ANSIBALLZ: Renaming module
    88247 1512328570.85245: ANSIBALLZ: Done creating module
    88247 1512328570.85407: _low_level_execute_command(): starting
    88247 1512328570.85415: _low_level_execute_command(): executing: /bin/sh -c 'echo ~ && sleep 0'
    88247 1512328570.85429: in local.exec_command()
    88247 1512328570.85435: opening command with Popen()
    88247 1512328570.85823: done running command with Popen()
    88247 1512328570.85842: getting output with communicate()
    88247 1512328570.86905: done communicating
    88247 1512328570.86927: done with local.exec_command()
    88247 1512328570.86946: _low_level_execute_command() done: rc=0, stdout=/Users/trupp
   , stderr=
    88247 1512328570.86958: _low_level_execute_command(): starting
    88247 1512328570.86967: _low_level_execute_command(): executing: /bin/sh -c '(...
    88247 1512328570.86979: in local.exec_command()
    88247 1512328570.86985: opening command with Popen()
    88247 1512328570.87401: done running command with Popen()
    88247 1512328570.87426: getting output with communicate()
    88247 1512328570.89015: done communicating
    88247 1512328570.89025: done with local.exec_command()
    88247 1512328570.89042: _low_level_execute_command() done: rc=0, stdout=ansibl...
   , stderr=
    88247 1512328570.89055: transferring module to remote /Users/trupp/.ansible/tm...
    88247 1512328570.89245: done transferring module to remote
    88247 1512328570.89266: _low_level_execute_command(): starting
    88247 1512328570.89273: _low_level_execute_command(): executing: /bin/sh -c 'c...
    88247 1512328570.89283: in local.exec_command()
    88247 1512328570.89288: opening command with Popen()
    88247 1512328570.89634: done running command with Popen()
    88247 1512328570.89665: getting output with communicate()
    88247 1512328570.91161: done communicating
    88247 1512328570.91171: done with local.exec_command()
    88247 1512328570.91192: _low_level_execute_command() done: rc=0, stdout=, stderr=
    88247 1512328570.91200: _low_level_execute_command(): starting
    88247 1512328570.91211: _low_level_execute_command(): executing: /bin/sh -c '...
    88247 1512328570.91223: in local.exec_command()
    88247 1512328570.91229: opening command with Popen()
    88247 1512328570.91581: done running command with Popen()
    88247 1512328570.91614: getting output with communicate()
    88247 1512328571.28618: done communicating
    88247 1512328571.28630: done with local.exec_command()
    88247 1512328571.28655: _low_level_execute_command() done: rc=0, stdout=
   {"invocation": {"module_args": {"filter": "*", "gather_subset": ["all"], "fact...
   , stderr=
    88247 1512328571.29273: done with _execute_module (setup, {'_ansible_version':...
    88247 1512328571.29291: handler run complete
    88247 1512328571.34550: attempt loop complete, returning result
    88247 1512328571.34576: _execute() done
    88247 1512328571.34583: dumping result to json
    88247 1512328571.34671: done dumping result, returning
    88247 1512328571.34683: done running TaskExecutor() for localhost/TASK: Gather...
    88247 1512328571.34699: sending task result for task 8c85904d-91d6-70e5-2197-0...
    88247 1512328571.34737: done sending task result for task 8c85904d-91d6-70e5-2...
    88247 1512328571.35092: WORKER PROCESS EXITING
   ok: [localhost]
    88233 1512328571.36570: no more pending results, returning what we have
    88233 1512328571.36579: results queue empty
    88233 1512328571.36583: checking for any_errors_fatal
    88233 1512328571.36588: done checking for any_errors_fatal
    88233 1512328571.36592: checking for max_fail_percentage
    88233 1512328571.36596: done checking for max_fail_percentage
    88233 1512328571.36600: checking to see if all hosts have failed and the runn...
    88233 1512328571.36604: done checking to see if all hosts have failed
    88233 1512328571.36608: getting the remaining hosts for this loop
    88233 1512328571.36616: done getting the remaining hosts for this loop
    88233 1512328571.36626: building list of next tasks for hosts
    88233 1512328571.36631: getting the next task for host localhost
    88233 1512328571.36638: done getting next task for host localhost
    88233 1512328571.36644:  ^ task is: TASK: meta (flush_handlers)
    88233 1512328571.37533:  ^ state is: HOST STATE: block=1, task=1, rescue=0, alw...
    88233 1512328571.37544: done building task lists
    88233 1512328571.37549: counting tasks in each state of execution
    88233 1512328571.37555: done counting tasks in each state of execution:
           num_setups: 0
           num_tasks: 1
           num_rescue: 0
           num_always: 0
    88233 1512328571.37567: advancing hosts in ITERATING_TASKS
    88233 1512328571.37572: starting to advance hosts
    88233 1512328571.37576: getting the next task for host localhost
    88233 1512328571.37583: done getting next task for host localhost
    88233 1512328571.37589:  ^ task is: TASK: meta (flush_handlers)
    88233 1512328571.37594:  ^ state is: HOST STATE: block=1, task=1, rescue=0, alwa...
    88233 1512328571.37600: done advancing hosts to next task
    88233 1512328571.37619: done queuing things up, now waiting for results queue to...
    88233 1512328571.37626: results queue empty
    88233 1512328571.37631: checking for any_errors_fatal
    88233 1512328571.37636: done checking for any_errors_fatal
    88233 1512328571.37641: checking for max_fail_percentage
    88233 1512328571.37646: done checking for max_fail_percentage
    88233 1512328571.37650: checking to see if all hosts have failed and the running result is not ok
    88233 1512328571.37655: done checking to see if all hosts have failed
    88233 1512328571.37660: getting the remaining hosts for this loop
    88233 1512328571.37669: done getting the remaining hosts for this loop
    88233 1512328571.37680: building list of next tasks for hosts
    88233 1512328571.37686: getting the next task for host localhost
    88233 1512328571.37698: done getting next task for host localhost
    88233 1512328571.37705:  ^ task is: TASK: Run a task
    88233 1512328571.37710:  ^ state is: HOST STATE: block=2, task=1, rescue=0, always=0,...
    88233 1512328571.37715: done building task lists
    88233 1512328571.37720: counting tasks in each state of execution
    88233 1512328571.37725: done counting tasks in each state of execution:
           num_setups: 0
           num_tasks: 1
           num_rescue: 0
           num_always: 0
    88233 1512328571.37732: advancing hosts in ITERATING_TASKS
    88233 1512328571.37736: starting to advance hosts
    88233 1512328571.37741: getting the next task for host localhost
    88233 1512328571.37748: done getting next task for host localhost
    88233 1512328571.37754:  ^ task is: TASK: Run a task
    88233 1512328571.37759:  ^ state is: HOST STATE: block=2, task=1, rescue=0, always=0,...
    88233 1512328571.37764: done advancing hosts to next task
    88233 1512328571.37964: Loading ActionModule 'set_fact' from /Users/trupp/src/envs/f5...
    88233 1512328571.37977: getting variables
    88233 1512328571.37985: in VariableManager get_vars()
    88233 1512328571.38064: Loading FilterModule 'core' from /Users/trupp/src/envs/f5ansi...
    88233 1512328571.38074: Loading FilterModule 'ipaddr' from /Users/trupp/src/envs/f5an...
    88233 1512328571.38082: Loading FilterModule 'json_query' from /Users/trupp/src/envs/...
    88233 1512328571.38088: Loading FilterModule 'mathstuff' from /Users/trupp/src/envs/f...
    88233 1512328571.38095: Loading FilterModule 'network' from /Users/trupp/src/envs/f5a...
    88233 1512328571.38102: Loading FilterModule 'urlsplit' from /Users/trupp/src/envs/f5...
    88233 1512328571.38135: Loading TestModule 'core' from /Users/trupp/src/envs/f5ansibl...
    88233 1512328571.38142: Loading TestModule 'files' from /Users/trupp/src/envs/f5ansib...
    88233 1512328571.38148: Loading TestModule 'mathstuff' from /Users/trupp/src/envs/f5a...
    88233 1512328571.38235: Calling all_inventory to load vars for localhost
    88233 1512328571.38246: Calling groups_inventory to load vars for localhost
    88233 1512328571.38253: Calling all_plugins_inventory to load vars for localhost
    88233 1512328571.38277: Loading VarsModule 'host_group_vars' from /Users/trupp/src/en...
    88233 1512328571.38305: Calling all_plugins_play to load vars for localhost
    88233 1512328571.38323: Loading VarsModule 'host_group_vars' from /Users/trupp/src/en...
    88233 1512328571.38344: Calling groups_plugins_inventory to load vars for localhost
    88233 1512328571.38365: Loading VarsModule 'host_group_vars' from /Users/trupp/src/en...
    88233 1512328571.38386: Calling groups_plugins_play to load vars for localhost
    88233 1512328571.38405: Loading VarsModule 'host_group_vars' from /Users/trupp/src/en...
    88233 1512328571.38440: Loading VarsModule 'host_group_vars' from /Users/trupp/src/en...
    88233 1512328571.38472: Loading VarsModule 'host_group_vars' from /Users/trupp/src/en...
    88233 1512328571.39665: done with get_vars()
    88233 1512328571.39684: done getting variables
    88233 1512328571.39691: sending task start callback, copying the task so we can template
    88233 1512328571.39696: done copying, going to template now
    88233 1512328571.39702: done templating
    88233 1512328571.39706: here goes the callback...

   TASK [Run a task] ***********************************************************************
    88233 1512328571.39718: sending task start callback
    88233 1512328571.39723: entering _queue_task() for localhost/set_fact
    88233 1512328571.39728: Creating lock for set_fact
    88233 1512328571.39884: worker is 1 (out of 1 available)
    88233 1512328571.39947: exiting _queue_task() for localhost/set_fact
    88233 1512328571.39969: done queuing things up, now waiting for results queue to drain
    88233 1512328571.39976: waiting for pending results...
    88286 1512328571.40364: running TaskExecutor() for localhost/TASK: Run a task
    88286 1512328571.40509: in run() - task 8c85904d-91d6-70e5-2197-000000000008
    88286 1512328571.40615: calling self._execute()
    88286 1512328571.41878: Loading Connection 'local' from /Users/trupp/src/envs/f5ansible/...
    88286 1512328571.41995: Loading ShellModule 'csh' from /Users/trupp/src/envs/f5ansible/l...
    88286 1512328571.42067: Loading ShellModule 'fish' from /Users/trupp/src/envs/f5ansible/...
    88286 1512328571.42078: Loading ShellModule 'powershell' from /Users/trupp/src/envs/f5an...
    88286 1512328571.42086: Loading ShellModule 'sh' from /Users/trupp/src/envs/f5ansible/li...
    88286 1512328571.42133: Loading ShellModule 'sh' from /Users/trupp/src/envs/f5ansible/li...
    88286 1512328571.42792: assigned :doc
    88286 1512328571.42850: Loading ActionModule 'set_fact' from /Users/trupp/src/envs/f5ans...
    88286 1512328571.42863: starting attempt loop
    88286 1512328571.42872: running the handler
    88286 1512328571.42889: handler run complete
    88286 1512328571.43127: attempt loop complete, returning result
    88286 1512328571.43133: _execute() done
    88286 1512328571.43137: dumping result to json
    88286 1512328571.43142: done dumping result, returning
    88286 1512328571.43148: done running TaskExecutor() for localhost/TASK: Run a task [8c85...
    88286 1512328571.43160: sending task result for task 8c85904d-91d6-70e5-2197-000000000008
    88286 1512328571.43188: done sending task result for task 8c85904d-91d6-70e5-2197-000000000008
    88286 1512328571.43216: WORKER PROCESS EXITING
   ok: [localhost]
    88233 1512328571.43625: no more pending results, returning what we have
    88233 1512328571.43638: results queue empty
    88233 1512328571.43643: checking for any_errors_fatal
    88233 1512328571.43650: done checking for any_errors_fatal
    88233 1512328571.43655: checking for max_fail_percentage
    88233 1512328571.43660: done checking for max_fail_percentage
    88233 1512328571.43665: checking to see if all hosts have failed and the running result is not ok
    88233 1512328571.43669: done checking to see if all hosts have failed
    88233 1512328571.43674: getting the remaining hosts for this loop
    88233 1512328571.43685: done getting the remaining hosts for this loop
    88233 1512328571.43699: building list of next tasks for hosts
    88233 1512328571.43706: getting the next task for host localhost
    88233 1512328571.43717: done getting next task for host localhost
    88233 1512328571.43724:  ^ task is: TASK: Run a second task
    88233 1512328571.43731:  ^ state is: HOST STATE: block=2, task=2, rescue=0, always=0, ru...
    88233 1512328571.43742: done building task lists
    88233 1512328571.43747: counting tasks in each state of execution
    88233 1512328571.43753: done counting tasks in each state of execution:
           num_setups: 0
           num_tasks: 1
           num_rescue: 0
           num_always: 0
    88233 1512328571.43771: advancing hosts in ITERATING_TASKS
    88233 1512328571.43776: starting to advance hosts
    88233 1512328571.43781: getting the next task for host localhost
    88233 1512328571.43788: done getting next task for host localhost
    88233 1512328571.43794:  ^ task is: TASK: Run a second task
    88233 1512328571.43800:  ^ state is: HOST STATE: block=2, task=2, rescue=0, always=0, ru...
    88233 1512328571.43805: done advancing hosts to next task
    88233 1512328571.44173: Loading ActionModule 'debug' from /Users/trupp/src/envs/f5ansibl...
    88233 1512328571.44187: getting variables
    88233 1512328571.44193: in VariableManager get_vars()
    88233 1512328571.44265: Loading FilterModule 'core' from /Users/trupp/src/envs/f5ansible...
    88233 1512328571.44279: Loading FilterModule 'ipaddr' from /Users/trupp/src/envs/f5ansib...
    88233 1512328571.44288: Loading FilterModule 'json_query' from /Users/trupp/src/envs/f5a...
    88233 1512328571.44297: Loading FilterModule 'mathstuff' from /Users/trupp/src/envs/f5an...
    88233 1512328571.44305: Loading FilterModule 'network' from /Users/trupp/src/envs/f5ansi...
    88233 1512328571.44313: Loading FilterModule 'urlsplit' from /Users/trupp/src/envs/f5ans...
    88233 1512328571.44355: Loading TestModule 'core' from /Users/trupp/src/envs/f5ansible/l...
    88233 1512328571.44364: Loading TestModule 'files' from /Users/trupp/src/envs/f5ansible/...
    88233 1512328571.44371: Loading TestModule 'mathstuff' from /Users/trupp/src/envs/f5ansi...
    88233 1512328571.44496: Calling all_inventory to load vars for localhost
    88233 1512328571.44510: Calling groups_inventory to load vars for localhost
    88233 1512328571.44519: Calling all_plugins_inventory to load vars for localhost
    88233 1512328571.44550: Loading VarsModule 'host_group_vars' from /Users/trupp/src/envs/...
    88233 1512328571.44577: Calling all_plugins_play to load vars for localhost
    88233 1512328571.44596: Loading VarsModule 'host_group_vars' from /Users/trupp/src/envs/...
    88233 1512328571.44618: Calling groups_plugins_inventory to load vars for localhost
    88233 1512328571.44639: Loading VarsModule 'host_group_vars' from /Users/trupp/src/envs/...
    88233 1512328571.44660: Calling groups_plugins_play to load vars for localhost
    88233 1512328571.44679: Loading VarsModule 'host_group_vars' from /Users/trupp/src/envs/...
    88233 1512328571.44716: Loading VarsModule 'host_group_vars' from /Users/trupp/src/envs/...
    88233 1512328571.44748: Loading VarsModule 'host_group_vars' from /Users/trupp/src/envs/...
    88233 1512328571.46020: done with get_vars()
    88233 1512328571.46053: done getting variables
    88233 1512328571.46063: sending task start callback, copying the task so we can template...
    88233 1512328571.46068: done copying, going to template now
    88233 1512328571.46075: done templating
    88233 1512328571.46080: here goes the callback...

   TASK [Run a second task] ****************************************************************
    88233 1512328571.46094: sending task start callback
    88233 1512328571.46101: entering _queue_task() for localhost/debug
    88233 1512328571.46107: Creating lock for debug
    88233 1512328571.46271: worker is 1 (out of 1 available)
    88233 1512328571.46329: exiting _queue_task() for localhost/debug
    88233 1512328571.46354: done queuing things up, now waiting for results queue to drain
    88233 1512328571.46360: waiting for pending results...
    88287 1512328571.46821: running TaskExecutor() for localhost/TASK: Run a second task
    88287 1512328571.46936: in run() - task 8c85904d-91d6-70e5-2197-00000000000a
    88287 1512328571.47046: calling self._execute()
    88287 1512328571.47350: Loading FilterModule 'core' from /Users/trupp/src/envs/f5ansible...
    88287 1512328571.47365: Loading FilterModule 'ipaddr' from /Users/trupp/src/envs/f5ansib...
    88287 1512328571.47375: Loading FilterModule 'json_query' from /Users/trupp/src/envs/f5a...
    88287 1512328571.47383: Loading FilterModule 'mathstuff' from /Users/trupp/src/envs/f5an...
    88287 1512328571.47391: Loading FilterModule 'network' from /Users/trupp/src/envs/f5ansi...
    88287 1512328571.47399: Loading FilterModule 'urlsplit' from /Users/trupp/src/envs/f5ans...
    88287 1512328571.47735: Loading TestModule 'core' from /Users/trupp/src/envs/f5ansible/l...
    88287 1512328571.47745: Loading TestModule 'files' from /Users/trupp/src/envs/f5ansible/...
    88287 1512328571.47753: Loading TestModule 'mathstuff' from /Users/trupp/src/envs/f5ansi...
    88287 1512328571.48550: when evaluation is False, skipping this task
    88287 1512328571.48563: _execute() done
    88287 1512328571.48571: dumping result to json
    88287 1512328571.48580: done dumping result, returning
    88287 1512328571.48588: done running TaskExecutor() for localhost/TASK: Run a second tas...
    88287 1512328571.48607: sending task result for task 8c85904d-91d6-70e5-2197-00000000000a
    88287 1512328571.48641: done sending task result for task 8c85904d-91d6-70e5-2197-00000000000a
    88287 1512328571.48649: WORKER PROCESS EXITING
   skipping: [localhost]
    88233 1512328571.49095: no more pending results, returning what we have
    88233 1512328571.49106: results queue empty
    88233 1512328571.49111: checking for any_errors_fatal
    88233 1512328571.49131: done checking for any_errors_fatal
    88233 1512328571.49140: checking for max_fail_percentage
    88233 1512328571.49146: done checking for max_fail_percentage
    88233 1512328571.49151: checking to see if all hosts have failed and the running result is not ok
    88233 1512328571.49157: done checking to see if all hosts have failed
    88233 1512328571.49162: getting the remaining hosts for this loop
    88233 1512328571.49190: done getting the remaining hosts for this loop
    88233 1512328571.49200: building list of next tasks for hosts
    88233 1512328571.49208: getting the next task for host localhost
    88233 1512328571.49220: done getting next task for host localhost
    88233 1512328571.49228:  ^ task is: TASK: Run a third task
    88233 1512328571.49239:  ^ state is: HOST STATE: block=2, task=3, rescue=0, always=0, ru...
    88233 1512328571.49249: done building task lists
    88233 1512328571.49254: counting tasks in each state of execution
    88233 1512328571.49260: done counting tasks in each state of execution:
           num_setups: 0
           num_tasks: 1
           num_rescue: 0
           num_always: 0
    88233 1512328571.49273: advancing hosts in ITERATING_TASKS
    88233 1512328571.49278: starting to advance hosts
    88233 1512328571.49283: getting the next task for host localhost
    88233 1512328571.49289: done getting next task for host localhost
    88233 1512328571.49295:  ^ task is: TASK: Run a third task
    88233 1512328571.49302:  ^ state is: HOST STATE: block=2, task=3, rescue=0, always=0, ru...
    88233 1512328571.49308: done advancing hosts to next task
    88233 1512328571.49899: Loading ActionModule 'debug' from /Users/trupp/src/envs/f5ansibl...
    88233 1512328571.49921: getting variables
    88233 1512328571.49930: in VariableManager get_vars()
    88233 1512328571.50084: Loading FilterModule 'core' from /Users/trupp/src/envs/f5ansible...
    88233 1512328571.50096: Loading FilterModule 'ipaddr' from /Users/trupp/src/envs/f5ansib...
    88233 1512328571.50104: Loading FilterModule 'json_query' from /Users/trupp/src/envs/f5a...
    88233 1512328571.50111: Loading FilterModule 'mathstuff' from /Users/trupp/src/envs/f5an...
    88233 1512328571.50118: Loading FilterModule 'network' from /Users/trupp/src/envs/f5ansi...
    88233 1512328571.50124: Loading FilterModule 'urlsplit' from /Users/trupp/src/envs/f5ans...
    88233 1512328571.50166: Loading TestModule 'core' from /Users/trupp/src/envs/f5ansible/l...
    88233 1512328571.50174: Loading TestModule 'files' from /Users/trupp/src/envs/f5ansible/...
    88233 1512328571.50181: Loading TestModule 'mathstuff' from /Users/trupp/src/envs/f5ansi...
    88233 1512328571.50273: Calling all_inventory to load vars for localhost
    88233 1512328571.50283: Calling groups_inventory to load vars for localhost
    88233 1512328571.50291: Calling all_plugins_inventory to load vars for localhost
    88233 1512328571.50321: Loading VarsModule 'host_group_vars' from /Users/trupp/src/envs/...
    88233 1512328571.50370: Calling all_plugins_play to load vars for localhost
    88233 1512328571.50407: Loading VarsModule 'host_group_vars' from /Users/trupp/src/envs/...
    88233 1512328571.50438: Calling groups_plugins_inventory to load vars for localhost
    88233 1512328571.50469: Loading VarsModule 'host_group_vars' from /Users/trupp/src/envs/...
    88233 1512328571.50494: Calling groups_plugins_play to load vars for localhost
    88233 1512328571.50516: Loading VarsModule 'host_group_vars' from /Users/trupp/src/envs/...
    88233 1512328571.50558: Loading VarsModule 'host_group_vars' from /Users/trupp/src/envs/...
    88233 1512328571.50594: Loading VarsModule 'host_group_vars' from /Users/trupp/src/envs/...
    88233 1512328571.51987: done with get_vars()
    88233 1512328571.52010: done getting variables
    88233 1512328571.52019: sending task start callback, copying the task so we can template...
    88233 1512328571.52025: done copying, going to template now
    88233 1512328571.52033: done templating
    88233 1512328571.52047: here goes the callback...

   TASK [Run a third task] *****************************************************************
    88233 1512328571.52066: sending task start callback
    88233 1512328571.52073: entering _queue_task() for localhost/debug
    88233 1512328571.52246: worker is 1 (out of 1 available)
    88233 1512328571.52320: exiting _queue_task() for localhost/debug
    88233 1512328571.52345: done queuing things up, now waiting for results queue to drain
    88233 1512328571.52351: waiting  88288 1512328571.52817: running TaskExecutor() for loca...
   for pending results...
    88288 1512328571.53010: in run() - task 8c85904d-91d6-70e5-2197-00000000000c
    88288 1512328571.53117: calling self._execute()
    88288 1512328571.53492: Loading FilterModule 'core' from /Users/trupp/src/envs/f5ansible...
    88288 1512328571.53523: Loading FilterModule 'ipaddr' from /Users/trupp/src/envs/f5ansib...
    88288 1512328571.53539: Loading FilterModule 'json_query' from /Users/trupp/src/envs/f5a...
    88288 1512328571.53551: Loading FilterModule 'mathstuff' from /Users/trupp/src/envs/f5an...
    88288 1512328571.53562: Loading FilterModule 'network' from /Users/trupp/src/envs/f5ansi...
    88288 1512328571.53576: Loading FilterModule 'urlsplit' from /Users/trupp/src/envs/f5ans...
    88288 1512328571.53665: Loading TestModule 'core' from /Users/trupp/src/envs/f5ansible/l...
    88288 1512328571.53676: Loading TestModule 'files' from /Users/trupp/src/envs/f5ansible/...
    88288 1512328571.53683: Loading TestModule 'mathstuff' from /Users/trupp/src/envs/f5ansi...
    88288 1512328571.55223: Loading Connection 'local' from /Users/trupp/src/envs/f5ansible/...
    88288 1512328571.55376: Loading ShellModule 'csh' from /Users/trupp/src/envs/f5ansible/l...
    88288 1512328571.55476: Loading ShellModule 'fish' from /Users/trupp/src/envs/f5ansible/...
    88288 1512328571.55497: Loading ShellModule 'powershell' from /Users/trupp/src/envs/f5an...
    88288 1512328571.55509: Loading ShellModule 'sh' from /Users/trupp/src/envs/f5ansible/li...
    88288 1512328571.55560: Loading ShellModule 'sh' from /Users/trupp/src/envs/f5ansible/li...
    88288 1512328571.56124: assigned :doc
    88288 1512328571.56194: Loading ActionModule 'debug' from /Users/trupp/src/envs/f5ansibl...
    88288 1512328571.56211: starting attempt loop
    88288 1512328571.56218: running the handler
    88288 1512328571.56362: handler run complete
    88288 1512328571.56372: attempt loop complete, returning result
    88288 1512328571.56380: _execute() done
    88288 1512328571.56385: dumping result to json
    88288 1512328571.56392: done dumping result, returning
    88288 1512328571.56405: done running TaskExecutor() for localhost/TASK: Run a third task...
    88288 1512328571.56423: sending task result for task 8c85904d-91d6-70e5-2197-00000000000c
    88288 1512328571.56471: done sending task result for task 8c85904d-91d6-70e5-2197-00000000000c
    88288 1512328571.56505: WORKER PROCESS EXITING
   ok: [localhost] => {
       "fact1": "foo"
   }
    88233 1512328571.57041: no more pending results, returning what we have
    88233 1512328571.57072: results queue empty
    88233 1512328571.57086: checking for any_errors_fatal
    88233 1512328571.57113: done checking for any_errors_fatal
    88233 1512328571.57123: checking for max_fail_percentage
    88233 1512328571.57132: done checking for max_fail_percentage
    88233 1512328571.57138: checking to see if all hosts have failed and the running result is not ok
    88233 1512328571.57149: done checking to see if all hosts have failed
    88233 1512328571.57159: getting the remaining hosts for this loop
    88233 1512328571.57201: done getting the remaining hosts for this loop
    88233 1512328571.57223: building list of next tasks for hosts
    88233 1512328571.57235: getting the next task for host localhost
    88233 1512328571.57270: done getting next task for host localhost
    88233 1512328571.57284:  ^ task is: TASK: meta (flush_handlers)
    88233 1512328571.57306:  ^ state is: HOST STATE: block=3, task=1, rescue=0, always=0, ru...
    88233 1512328571.57320: done building task lists
    88233 1512328571.57326: counting tasks in each state of execution
    88233 1512328571.57335: done counting tasks in each state of execution:
           num_setups: 0
           num_tasks: 1
           num_rescue: 0
           num_always: 0
    88233 1512328571.57356: advancing hosts in ITERATING_TASKS
    88233 1512328571.57372: starting to advance hosts
    88233 1512328571.57378: getting the next task for host localhost
    88233 1512328571.57389: done getting next task for host localhost
    88233 1512328571.57396:  ^ task is: TASK: meta (flush_handlers)
    88233 1512328571.57402:  ^ state is: HOST STATE: block=3, task=1, rescue=0, always=0, run...
    88233 1512328571.57418: done advancing hosts to next task
    88233 1512328571.57485: done queuing things up, now waiting for results queue to drain
    88233 1512328571.57492: results queue empty
    88233 1512328571.57497: checking for any_errors_fatal
    88233 1512328571.57503: done checking for any_errors_fatal
    88233 1512328571.57507: checking for max_fail_percentage
    88233 1512328571.57512: done checking for max_fail_percentage
    88233 1512328571.57517: checking to see if all hosts have failed and the running result is not ok
    88233 1512328571.57521: done checking to see if all hosts have failed
    88233 1512328571.57526: getting the remaining hosts for this loop
    88233 1512328571.57532: done getting the remaining hosts for this loop
    88233 1512328571.57540: building list of next tasks for hosts
    88233 1512328571.57545: getting the next task for host localhost
    88233 1512328571.57552: done getting next task for host localhost
    88233 1512328571.57558:  ^ task is: TASK: meta (flush_handlers)
    88233 1512328571.57563:  ^ state is: HOST STATE: block=4, task=1, rescue=0, always=0, run_st...
    88233 1512328571.57569: done building task lists
    88233 1512328571.57573: counting tasks in each state of execution
    88233 1512328571.57578: done counting tasks in each state of execution:
           num_setups: 0
           num_tasks: 1
           num_rescue: 0
           num_always: 0
    88233 1512328571.57584: advancing hosts in ITERATING_TASKS
    88233 1512328571.57589: starting to advance hosts
    88233 1512328571.57594: getting the next task for host localhost
    88233 1512328571.57600: done getting next task for host localhost
    88233 1512328571.57606:  ^ task is: TASK: meta (flush_handlers)
    88233 1512328571.57611:  ^ state is: HOST STATE: block=4, task=1, rescue=0, always=0, run_st...
    88233 1512328571.57616: done advancing hosts to next task
    88233 1512328571.57626: done queuing things up, now waiting for results queue to drain
    88233 1512328571.57632: results queue empty
    88233 1512328571.57637: checking for any_errors_fatal
    88233 1512328571.57642: done checking for any_errors_fatal
    88233 1512328571.57646: checking for max_fail_percentage
    88233 1512328571.57651: done checking for max_fail_percentage
    88233 1512328571.57656: checking to see if all hosts have failed and the running result is not ok
    88233 1512328571.57660: done checking to see if all hosts have failed
    88233 1512328571.57665: getting the remaining hosts for this loop
    88233 1512328571.57671: done getting the remaining hosts for this loop
    88233 1512328571.57678: building list of next tasks for hosts
    88233 1512328571.57683: getting the next task for host localhost
    88233 1512328571.57689: done getting next task for host localhost
    88233 1512328571.57694:  ^ task is: None
    88233 1512328571.57700:  ^ state is: HOST STATE: block=5, task=0, rescue=0, always=0, run_st...
    88233 1512328571.57705: done building task lists
    88233 1512328571.57710: counting tasks in each state of execution
    88233 1512328571.57714: done counting tasks in each state of execution:
           num_setups: 0
           num_tasks: 0
           num_rescue: 0
           num_always: 0
    88233 1512328571.57720: all hosts are done, so returning None's for all hosts
    88233 1512328571.57725: done queuing things up, now waiting for results queue to drain
    88233 1512328571.57730: results queue empty
    88233 1512328571.57735: checking for any_errors_fatal
    88233 1512328571.57739: done checking for any_errors_fatal
    88233 1512328571.57744: checking for max_fail_percentage
    88233 1512328571.57749: done checking for max_fail_percentage
    88233 1512328571.57753: checking to see if all hosts have failed and the running result is not ok
    88233 1512328571.57758: done checking to see if all hosts have failed
    88233 1512328571.57764: getting the next task for host localhost
    88233 1512328571.57771: done getting next task for host localhost
    88233 1512328571.57776:  ^ task is: None
    88233 1512328571.57781:  ^ state is: HOST STATE: block=5, task=0, rescue=0, always=0, run_st...
    88233 1512328571.57787: running handlers

   PLAY RECAP **********************************************************************************
   localhost                  : ok=3    changed=0    unreachable=0    failed=0

Discussion
----------

Debug output is not very useful unless you are debugging a core problem with Ansible.
It is also useful, in some cases, when you need to debug a module.

The reason we are showing it to you here is because it may be requested of you when
you report problems to the F5 Ansible developers.

Debug output shows the detailed execution of the Ansible engine as it processes the
playbook and the modules.
