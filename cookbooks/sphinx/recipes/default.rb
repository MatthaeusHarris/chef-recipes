#
# Cookbook Name:: sphinx
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

  directory node[:sphinx][:src_path] do
    owner "root"
    group "root"
    mode "0755"
    action :create
    only_if do File.exists?(node[:sphinx][:path])
  end

  remote_file node[:sphinx][:tar_file] do
    source node[:sphinx][:url]
    mode "0755"
    checksum node[:sphinx][:tar_file_checksum]
  end

  remote_file "#{node[:sphinx][:src_path]}/libstemmer_c.tgz" do
    source "http://snowball.tartarus.org/dist/libstemmer_c.tgz"
    mode "0755"
    checksum "b642b8921915128bd95c99d302d33701cba8b5afbda81b762c118cbadfb7670f"
  end

  script "install_sphinx" do
    interpreter "bash"
    user "root"
    cwd node[:sphinx][:src_path]
    not_if "test -f /usr/local/bin/searchd"
    code <<-EOH
    tar -xvf #{node[:sphinx][:tar_file]}
    cd  #{node[:sphinx][:version]}
    tar -xvf ../libstemmer_c.tgz
    ./configure #{node[:sphinx][:configure_options]}
    make
    make install
    EOH
   end
end
