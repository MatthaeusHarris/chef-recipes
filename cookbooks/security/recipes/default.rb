#
# Cookbook Name:: security
# Recipe:: default
#
# Copyright 2009, Example Com
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


packages = %w{ denyhosts }

packages.each do |p|
  package p do
    action :install
  end
end

service "denyhosts" do
  supports :restart => true
end

service "sshd" do
  supports :reload => true
end

remote_file "/usr/local/sbin/unban-ip" do
  source "unban-ip"
  mode "0755"
  owner "root"
  group "root"
end


remote_file "/etc/denyhosts.conf" do
  source "denyhosts.conf"
    mode "0644"
    owner "root"
    group "root"
  notifies :restart, resources(:service => "sshd")
end

remote_file "/etc/ssh/sshd_config" do
  source "sshd_config"
  mode "0644"
  owner "root"
  group "root"
  notifies :reload, resources(:service => "sshd")
end

service "denyhosts" do
# By default, the init provider is used, which runs /etc/init.d/service_name with _command.
  supports :restart => true, :reload => true
  action :restart
end
