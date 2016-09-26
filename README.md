telegraf-ng Cookbook
================

[![Cookbook](http://img.shields.io/badge/cookbook-v0.0.2-green.svg)](https://github.com/vkhatri/chef-telegraf-ng)

[![wercker status](https://app.wercker.com/status/454e213230cc1aff6ac2cce5cd528d32/m "wercker status")](https://app.wercker.com/project/bykey/454e213230cc1aff6ac2cce5cd528d32)


This is a [Chef] cookbook to manage InfluxDB [Telegraf].


>> For Production environment, always prefer the [most recent release](https://supermarket.chef.io/cookbooks/telegraf-ng).


## Most Recent Release

```ruby
cookbook 'telegraf', '~> 0.0.2'
```

## From Git

```ruby
cookbook 'telegraf', github: 'vkhatri/chef-telegraf',  tag: "v0.0.2"
```

## Repository

```
https://github.com/vkhatri/chef-telegraf-ng
```

## Supported OS

This cookbook was tested on Amazon & Ubuntu Linux and expected to work on other RHEL platforms.



## Cookbook Dependency

None

## TODO

- add ubuntu version pin support

## Recipes

- `telegraf::default` - default recipe (use it for run_list)

- `telegraf::install` - install telegraf

- `telegraf::config` - configure telegraf

- `telegraf::inputs` - configure telegraf inputs using node attribute `node['telegraf']['inputs']`

- `telegraf::outputs` - configure telegraf outputs using node attribute `node['telegraf']['outputs']`

- `telegraf::service` - configure telegraf service

- `telegraf::example` - examples recipe to configure default inputs/outputs using HWRP


## HWRP telegraf_input

HWRP `telegraf_input` creates telegraf inputs configuration files under directory `node['telegraf']['conf_d_dir']` with file name `input-#{resource_name}.conf`.


**HWRP example**

```ruby
telegraf_input 'cpu' do
  config fielddrop: ['time_*']
end
```

**HWRP Options**

- *action* (optional)	- default :create, options: :create, :delete
- *config* (optional, Hash)	- telegraf input options
- *name* (optional, String)	- telegraf input name


## HWRP telegraf_output

HWRP `telegraf_output` creates telegraf outputs configuration files under directory `node['telegraf']['conf_d_dir']` with file name `output-#{resource_name}.conf`.


**HWRP example**

```ruby
telegraf_output 'influxdb' do
  config urls: ['http://localhost:8086'], database: 'telegraf', precision: 's'
end
```

**HWRP Options**

- *action* (optional)	- default :create, options: :create, :delete
- *config* (optional, Hash)	- telegraf output options
- *name* (optional, String)	- telegraf output name


## How to Add Telegraf Input via Node Attribute

```json
{
  "default_attributes": {
    "telegraf": {
      "inputs": {
        "cpu": {
          "fielddrop": ["time_*"]
        },
        "disk": {
          "ignore_fs": ["tmpfs", "devtmpfs"]
        },
        "diskio": {},
        "kernel": {},
        "mem": {},
        "processes": {},
        "net": {
          "interfaces": ["eth0"]
        },
        "swap": {},
        "system": {},
        "ntpq": {},
        "netstat": {},
        "procstat": {
          "pattern": "/usr/bin/telegraf"
        }
      }
    }
  }
}
```

## How to Add Telegraf Output via Node Attribute

```json
{
  "default_attributes": {
    "telegraf": {
      "outputs": {
        "influxdb": {
          "urls": ["http://localhost:8086"],
          "database": "telegraf",
          "precision": "s"
        }
      }
    }
  }
}
```


## Core Attributes


* `default['telegraf']['version']` (default: `1.0.0`): telegraf version, applicable only to `rhel` platform

* `default['telegraf']['conf_dir']` (default: `/etc/telegraf`): telegraf toml configuration file directory

* `default['telegraf']['conf_d_dir']` (default: `/etc/telegraf/telegraf.d`): telegraf inputs/outputs configuration files directory

* `default['telegraf']['conf_file']` (default: `/etc/telegraf/telegraf.conf`): telegraf configuration file

* `default['telegraf']['notify_restart']` (default: `true`): whether to restart telegraf service on configuration file change

* `default['telegraf']['disable_service']` (default: `false`): whether to stop and disable telegraf service

* `default['telegraf']['user']` (default: `telegraf`): telegraf user

* `default['telegraf']['group']` (default: `telegraf`): telegraf group



## Configuration File telegraf.conf Attributes

* `default['telegraf']['config']['tags']` (default: `{}`): telegraf global tags

* `default['telegraf']['config']['agent']['interval']` (default: `10s`): telegraf agent configuration parameter

* `default['telegraf']['config']['agent']['round_interval']` (default: `true`): telegraf agent configuration parameter

* `default['telegraf']['config']['agent']['flush_interval']` (default: `10s`): telegraf agent configuration parameter

* `default['telegraf']['config']['agent']['flush_jitter']` (default: `5s`): telegraf agent configuration parameter



## telegraf YUM/APT Repository Attributes

* `default['telegraf']['yum']['description']` (default: ``): telegraf yum reporitory attribute

* `default['telegraf']['yum']['gpgcheck']` (default: `true`): telegraf yum reporitory attribute

* `default['telegraf']['yum']['enabled']` (default: `true`): telegraf yum reporitory attribute

* `default['telegraf']['yum']['baseurl']` (default: `calculated`): telegraf yum reporitory attribute

* `default['telegraf']['yum']['gpgkey']` (default: `https://repos.influxdata.com/influxdb.key`): telegraf yum reporitory attribute

* `default['telegraf']['yum']['action']` (default: `:create`): telegraf yum reporitory attribute


* `default['telegraf']['apt']['description']` (default: ``): telegraf apt reporitory attribute

* `default['telegraf']['apt']['components']` (default: `['stable']`): telegraf apt reporitory attribute

* `default['telegraf']['apt']['uri']` (default: `https//repos.influxdata.com/debian`): telegraf apt reporitory attribute

* `default['telegraf']['apt']['key']` (default: `https//repos.influxdata.com/influxdb.key`): telegraf apt reporitory attribute

* `default['telegraf']['apt']['action']` (default: `:add`): telegraf apt reporitory attribute


## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests (`rake & rake knife`), ensuring they all pass
6. Write new resource/attribute description to `README.md`
7. Write description about changes to PR
8. Submit a Pull Request using Github


## Copyright & License

Authors:: Virender Khatri and [Contributors]

<pre>
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
</pre>


[Chef]: https://www.chef.io/
[Telegraf]: https://docs.influxdata.com/telegraf
[InfluxDB]: https://influxdata.com/
[Contributors]: https://github.com/vkhatri/chef-telegraf-ng/graphs/contributors
