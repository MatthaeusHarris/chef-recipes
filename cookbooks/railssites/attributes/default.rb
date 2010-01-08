set[:railssites][:app1] = {
  :server_name => "app1.wadus.net",
  :user => "app1",
  :dbname => "app1_production",
  :dbuser => "app1",
  :dbpasswd => "XXXXXXXXXX",
  :dbhost => "dbserver.wadus.net",
  :ssl => true,
  :certificatechainfile => true,
  :config_files => %w(config.yml )
}

set[:railssites][:sequence] = {
  :server_name => "app2.wadus.net",
  :user => "app2",
  :dbname => "app2_production",
  :dbuser => "app2",
  :dbpasswd => "XXXXXXXXXXXX",
  :dbhost => "dbserver.wadus.net",
  :ssl => true,
  :certificatechainfile => true,
  :crontabs => true,
  :config_files => %w( config.yml )
}
