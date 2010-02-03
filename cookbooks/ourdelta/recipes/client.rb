repository "mysql-ourdelta" do
  key_url "http://ourdelta.org/deb/ourdelta.gpg"
  config_url "http://ourdelta.org/deb/sources/#{node[:lsb][:codename]}-#{node[:ourdelta][:repository]}.list"
end

package "mysql-client" do
  only_if do ["ourdelta","ourdelta-sail"].include?(node[:ourdelta][:repository]) end
end

package "mariadb-client" do
  only_if do node[:ourdelta][:repository]=="mariadb-ourdelta" end
end
