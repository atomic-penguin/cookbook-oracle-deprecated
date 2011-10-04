#
# Cookbook Name:: oracle
# Recipe:: default
#
# Copyright 2010, Eric G. Wolfe
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "x-windows"
include_recipe "gnome"
node.set["sysctl"]["is_oracle"] = true

node["oracle"]["db_packages"].each do |db_package|
  package db_package
end

template "/etc/security/limits.d/oracle.conf" do
  owner "root"
  group "root"
  mode "0644"
  source "oracle-limits.conf.erb"
end

template "/etc/profile.d/oracle-hostname.sh" do
  owner "root"
  group "root"
  mode "0755"
  source "oracle-hostname.sh.erb"
end

cookbook_file "/usr/local/bin/hugepage_settings" do
  owner "root"
  group "root"
  mode 0755
end

group "dba" do
  gid 200
  ignore_failure true
  members node["oracle"]["dbas"]
end

user "oracle" do
  comment "Oracle Service Account - DBA"
  uid 200
  gid "dba"
  home "/home/oracle"
  shell "/bin/bash"
  ignore_failure true
  supports :manage_home => true
end

directory "/u01/app/oracle" do
  owner "oracle"
  group "dba"
  mode "775"
  recursive true
end

include_recipe "el-sysctl"
