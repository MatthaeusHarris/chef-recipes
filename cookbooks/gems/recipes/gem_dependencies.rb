packages = %w{ libxslt1-dev libxml2 libxml2-dev imagemagick libfreeimage-dev libmagick9-dev libmysqlclient15-dev }

packages.each do |p|
  package p do
    action :install
  end
end
