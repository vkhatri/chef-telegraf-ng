name             'telegraf-ng'
maintainer       'Virender Khatri'
maintainer_email 'vir.khatri@gmail.com'
license          'Apache-2.0'
description      'Installs/Configures Influxdata Telegraf'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.6'

source_url 'https://github.com/vkhatri/chef-telegraf-ng' if respond_to?(:source_url)
issues_url 'https://github.com/vkhatri/chef-telegraf-ng/issues' if respond_to?(:issues_url)

chef_version '>= 12' if respond_to?(:chef_version)

depends 'apt'
depends 'yum-plugin-versionlock', '>= 0.1.2'

%w[debian ubuntu centos amazon redhat fedora].each do |os|
  supports os
end
