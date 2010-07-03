define :config_file, :options => { } do
  options=params[:options]

  if  params[:name].include?("/")
    dir=File.dirname(params[:name])
    directory "/home/#{options[:user]}/app/shared/config/#{dir}" do
      recursive true
      owner options[:user]
      group options[:user]
      mode "0755"
      not_if "test -d /home/#{options[:user]}/app/shared/config/#{dir}"
    end
  end

  options[:config_files].each do |f|
    remote_file "/home/#{options[:user]}/app/shared/config/#{f}" do
      source f
      owner appname
      group appname
      mode "0644"
    end
  end
end


