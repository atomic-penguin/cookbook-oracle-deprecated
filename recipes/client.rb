#
# Cookbook Name:: oracle
# Recipe:: client
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

node.set["sysctl"]["is_oracle_client"] = true

node["oracle"]["client_packages"].each do |client_package|
  package client_package
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

directory "/u01/app/oracle" do
  owner "oracle"
  group "dba"
  mode "775"
  recursive true
end

include_recipe "el-sysctl"
