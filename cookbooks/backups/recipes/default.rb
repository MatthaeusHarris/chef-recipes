#
# Cookbook Name:: backups
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


packages = %w{ duplicity python-boto s3cmd }

packages.each do |p|
  package p do
    action :install
  end
end


directory "/etc/backups" do
  owner "root"
  group "root"
  mode "0700"
  recursive true
  action :create
end

directory "/var/opt/backups/projects" do
  owner "root"
  group "root"
  mode "0755"
  recursive true
  action :create
end

remote_file "/etc/s3cfg" do
  source "s3cfg"
  owner "root"
  group "root"
  mode "0600"
end

remote_file "/usr/local/sbin/backups" do
  source "backups"
  owner "root"
  group "root"
  mode "0744"
end

remote_file "/etc/backups/backups.yml" do
  source "backups.yml"
  owner "root"
  group "root"
  mode "0600"
end

cron "backups" do
  hour "7"
  minute "00"
  user "root"
  command "/usr/local/sbin/backups"
  mailto "ballsbreaking@bebanjo.com"
  path "/usr/local/bin:/usr/bin:/bin"
end


