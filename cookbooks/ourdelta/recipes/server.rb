# -*- coding: utf-8 -*-
#
# Cookbook Name:: ourdelta
# Recipe:: default
#
# Copyright 2010, Jacobo García López de Araujo
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

repository "mysql-ourdelta" do
  key_url "http://ourdelta.org/deb/ourdelta.gpg"
  config_url "http://ourdelta.org/deb/sources/#{node[:lsb][:codename]}-#{node[:ourdelta][:repository]}.list"
end

package "mysql-server" do
  only_if do ["ourdelta","ourdelta-sail"].include?(node[:ourdelta][:repository]) end
end

package "mariadb-server" do
  only_if do node[:ourdelta][:repository]=="mariadb-ourdelta" end
end

execute "set-root password" do
  command "mysqladmin -u root password #{node[:ourdelta][:rootpwd]}"
  creates "/var/tmp/mysql-password"
  only_if do node[:ourdelta][:rootpwd] != nil end
end

file "/var/tmp/mysql-password" do
  only_if do node[:ourdelta][:rootpwd] != nil end
end
