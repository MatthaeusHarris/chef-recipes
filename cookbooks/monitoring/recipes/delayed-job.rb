include_recipe 'monitoring'

node[:monit][:delayed_job].each do |app,jobs|
  jobs.each do |job|
    template "/etc/monit/conf.d/delayed-job-#{app}-#{job}.monitrc" do
      source "delayed-job.erb"
      owner "root"
      group "root"
      mode 0644
      variables (:job => job, :appname => app)
      notifies :restart, resources (:service => "monit")
    end
  end
end
