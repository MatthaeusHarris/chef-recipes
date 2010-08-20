#
# Cookbook Name:: gems
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

include_recipe 'gems::gem_dependencies'

execute "gem-sources" do
  command "gem sources -a http://gems.github.com"
  user "root"
  creates "/var/tmp/gem-sources"
end

file "/var/tmp/gem-sources"

execute "gem-update" do
  command "gem update --system"
  user "root"
end

# Temporary fix when running chef 0.8

if node[:chef][:server_version]=~/0.8.(\d)+/
  node[:gems][:packages].each do |p|
    execute "gem-install" do
      command "#{node[:gems][:binary]} install #{p} --no-rdoc --no-ri"
      user "root"
      creates "/var/tmp/.gem-#{p}"
    end
  end
  file "/var/tmp/.gem-#{p}"

else
  node[:gems][:packages].each do |p|
    gem_package p do
      gem_binary node[:gems][:binary]
      action :install
    end
  end
end
