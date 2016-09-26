default['telegraf']['version'] = '1.0.0'
default['telegraf']['release'] = '1'
default['telegraf']['disable_service'] = false

default['telegraf']['user'] = 'telegraf'
default['telegraf']['group'] = 'telegraf'

default['telegraf']['notify_restart'] = true
default['telegraf']['conf_dir'] = '/etc/telegraf'
default['telegraf']['conf_d_dir'] = ::File.join(node['telegraf']['conf_dir'], 'telegraf.d')
default['telegraf']['conf_file'] = ::File.join(node['telegraf']['conf_dir'], 'telegraf.conf')

default['telegraf']['yum']['baseurl'] = value_for_platform(
  %w(amazon) => { 'default' => 'https://repos.influxdata.com/rhel/6/$basearch/stable' },
  %w(centos redhat fedora) => { 'default' => 'https://repos.influxdata.com/rhel/6/$basearch/stable' }
)

default['telegraf']['yum']['description'] = 'InfluxDB Repository - RHEL $releasever'
default['telegraf']['yum']['gpgcheck'] = true
default['telegraf']['yum']['enabled'] = true
default['telegraf']['yum']['gpgkey'] = 'https://repos.influxdata.com/influxdb.key'
default['telegraf']['yum']['metadata_expire'] = '3h'
default['telegraf']['yum']['action'] = :create

default['telegraf']['apt']['uri'] = "https://repos.influxdata.com/#{node['platform']}"
default['telegraf']['apt']['description'] = 'InfluxDB Repository'
default['telegraf']['apt']['components'] = %w(stable)
default['telegraf']['apt']['distribution'] = node['lsb']['codename']
default['telegraf']['apt']['action'] = :add
default['telegraf']['apt']['key'] = 'https://repos.influxdata.com/influxdb.key'
default['telegraf']['apt']['options'] = "-o Dpkg::Options::='--force-confnew'"
