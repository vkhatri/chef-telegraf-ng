#
# Cookbook Name:: telegraf-ng
# Recipe:: install
#
# Copyright 2015, Virender Khatri
#

case node['platform_family']
when 'debian'
  # apt repository configuration
  apt_repository 'influxdb' do
    uri node['telegraf']['apt']['uri']
    components node['telegraf']['apt']['components']
    key node['telegraf']['apt']['key']
    distribution node['telegraf']['apt']['distribution']
    action node['telegraf']['apt']['action']
  end

  unless node['telegraf']['ignore_version'] # ~FC023
    apt_preference 'telegraf' do
      pin          "version #{node['telegraf']['version']}"
      pin_priority '700'
    end
  end

when 'rhel', 'fedora', 'amazon'
  # yum repository configuration
  yum_repository 'influxdb' do
    description node['telegraf']['yum']['description']
    baseurl node['telegraf']['yum']['baseurl']
    gpgcheck node['telegraf']['yum']['gpgcheck']
    gpgkey node['telegraf']['yum']['gpgkey']
    enabled node['telegraf']['yum']['enabled']
    metadata_expire node['telegraf']['yum']['metadata_expire']
    action node['telegraf']['yum']['action']
  end

  # temp fix
  file '/etc/yum/pluginconf.d/versionlock.list' do
    action :create_if_missing
  end

  unless node['telegraf']['ignore_version'] # ~FC023
    yum_version_lock 'telegraf' do
      version node['telegraf']['version']
      release node['telegraf']['release']
      action :update
    end
  end
end

package 'telegraf' do # ~FC009
  version "#{node['telegraf']['version']}-#{node['telegraf']['release']}" unless node['telegraf']['ignore_version']
  options node['telegraf']['apt']['options'] if node['telegraf']['apt']['options'] && node['platform_family'] == 'debian'
  notifies :restart, 'service[telegraf]' if node['telegraf']['notify_restart'] && !node['telegraf']['disable_service']
  if %w[rhel amazon fedora].include?(node['platform_family'])
    flush_cache(:before => true)
    allow_downgrade true
  end
end
