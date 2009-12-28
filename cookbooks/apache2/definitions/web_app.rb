#
# Cookbook Name:: apache2
# Definition:: web_app
#
# Copyright 2008-2009, Opscode, Inc.
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

define :web_app, :template => "web_app.conf.erb" do

  application_name = params[:name]

  include_recipe "apache2"
  include_recipe "apache2::mod_rewrite"
  include_recipe "apache2::mod_deflate"
  include_recipe "apache2::mod_headers"

  template "#{node[:apache][:dir]}/sites-available/#{application_name}.conf" do
    source params[:template]
    owner "root"
    group "root"
    mode "0644"
    if params[:cookbook]
      cookbook params[:cookbook]
    end
    variables(
      :application_name => application_name,
      :params => params
    )
    if File.exists?("#{node[:apache][:dir]}/sites-enabled/#{application_name}.conf")
      notifies :reload, resources(:service => "apache2"), :delayed
    end
  end

  if params[:ssl]

    include_recipe "apache2::mod_ssl"

    directory "/etc/apache2/ssl" do
      owner "root"
      group "root"
      mode "0755"
      action :create
      not_if "test -d /etc/apache2/ssl"
    end

    remote_file "/etc/apache2/ssl/server.crt" do
      source "server.crt"
      owner "root"
      group "root"
      mode "0644"
    end

    remote_file "/etc/apache2/ssl/server.key" do
      source "server.key"
      owner "root"
      group "root"
      mode "0644"
    end

    if params[:certificatechainfile]
      remote_file "/etc/apache2/ssl/caauthority.crt" do
        source "caauthority.crt"
      end
    end
  end

  apache_site "#{params[:name]}.conf" do
    enable enable_setting
  end
end
