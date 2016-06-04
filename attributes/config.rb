default['telegraf']['config']['tags'] = {}
# default['telegraf']['config']['tags']['environment'] = node.environment
default['telegraf']['config']['agent']['interval'] = '10s'
default['telegraf']['config']['agent']['round_interval'] = 'true'
default['telegraf']['config']['agent']['flush_interval'] = '10s'
default['telegraf']['config']['agent']['flush_jitter'] = '5s'

default['telegraf']['inputs'] = {}
default['telegraf']['outputs'] = {}
