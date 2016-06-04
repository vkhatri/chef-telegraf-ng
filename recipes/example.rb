#
# Cookbook Name:: telegraf-ng
# Recipe:: example
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

# default inputs

telegraf_input 'diskio'
telegraf_input 'kernel'
telegraf_input 'mem'
telegraf_input 'processes'
telegraf_input 'swap'
telegraf_input 'system'
telegraf_input 'ntpq'
telegraf_input 'netstat'

telegraf_input 'cpu' do
  config fielddrop: ['time_*']
end

telegraf_input 'disk' do
  config ignore_fs: %w(tmpfs devtmpfs)
end

telegraf_input 'net' do
  config interfaces: ['eth0']
end

telegraf_input 'procstat' do
  config pattern: '/usr/bin/telegraf'
end

# default output
telegraf_output 'influxdb' do
  config urls: ['http://localhost:8086'], database: 'telegraf', precision: 's'
end
