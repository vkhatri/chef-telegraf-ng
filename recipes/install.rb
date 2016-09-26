#
# Cookbook Name:: telegraf-ng
# Recipe:: install
#
# Copyright 2015, Virender Khatri
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

version_string = node['platform_family'] == 'rhel' ? "#{node['telegraf']['version']}-#{node['telegraf']['release']}" : node['telegraf']['version']

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

when 'rhel'
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

  yum_version_lock 'telegraf' do
    version node['telegraf']['version']
    release node['telegraf']['release']
    action :update
  end
end

package 'telegraf' do # ~FC009
  options node['telegraf']['apt']['options'] if node['telegraf']['apt']['options'] && node['platform_family'] == 'debian'
  notifies :restart, 'service[telegraf]' if node['telegraf']['notify_restart'] && !node['telegraf']['disable_service']
  if node['platform_family'] == 'rhel'
    flush_cache(:before => true)
    allow_downgrade true
    version version_string
  end
end
