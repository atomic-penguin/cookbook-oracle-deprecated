DESCRIPTION:
===========

  This cookbook configures the pre-requisites for Oracle DB systems.
It depends on the x-windows, and gnome cookbooks for package requirements.
Also there is a dependency on the el-sysctl cookbook for kernel parameters.

  The cookbook does not install any components of Oracle, it simply
prepares the system for Oracle.

REQUIREMENTS:
=============

Required Cookbooks
---------------------

  * el-sysctl
  * x-windows
  * gnome

ATTRIBUTES:
===========

Oracle DB
---------

  * oracle (namespace)
    - ["version"]: 10 or 11, default 11
    - ["dbas"]: An array of usernames to add to the dba group.
    - ["db_packages"]: An array of packages required for Oracle DB
    - ["client_packages"]: An array of packages for Oracle client software
    - ["processes"]: PROCESSES paramenter from init.ora file, default 240

  * sysctl (namespace)
    - ["is_oracle_client"]: Either this or is_oracle needs to be true for el-sysctl
    - ["is_oracle"]: Either this or is_oracle_client needs to be true for el-sysctl
    - ["vm"]["nr_hugepages"]: Use included hugepage_settings script to calculate
    - NOTE: Other sysctl parameters are calculated within the attributes/default file
        according to Oracle pre-installation requirements. 

USAGE:
======

  Here is an example Oracle role, one might add for Chef.

```
name "oracle"
description "Install Oracle pre-requisites"
override_attributes "sysctl" => {
  "is_oracle" => true
},
"oracle" => {
  "dbas" => [ "bob" ],
  "version" => 10,
  "processes" => 512
}
```

LICENSE AND AUTHOR:
===================

Copyright 2010-2011, Eric G. Wolfe

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

