set[:railssites][:app1] = {
  :server_name => "app1.wadus.net",
  :server_aliases => [ "www.wadus.net" ],
  :user => "app1",
  :dbname => "app1_production",
  :dbuser => "app1",
  :dbpasswd => "XXXXXXXXXX",
  :dbhost => "dbserver.wadus.net",
  :type => :staging, #You can choose between :production, :production_ssl, :staging, :staging_ssl
  :includes => true,
  :certificatechainfile => true,
  :config_files => %w(config.yml ),
  :crontabs => true,
}

set[:railssites][:app2] = {
  :server_name => "app2.wadus.net",
  :server_aliases => [ "www.wadus.net" ],
  :user => "app2",
  :dbname => "app2_production",
  :dbuser => "app2",
  :dbpasswd => "XXXXXXXXXXXX",
  :dbhost => "dbserver.wadus.net",
  :type => :production, #You can choose between :production, :production_ssl, :staging, :staging_ssl
  :includes => true,
  :certificatechainfile => true,
  :crontabs => true,
  :config_files => %w( config.yml )
}
