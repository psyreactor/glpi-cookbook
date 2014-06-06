[![Build Status](https://travis-ci.org/psyreactor/glpi-cookbook.svg?branch=master)](https://travis-ci.org/psyreactor/glpi-cookbook)

Glpi Cookbook
===============

This cookbook install glpi from the source code.

####[The GLPI Proyect](http://www.glpi-project.org/)
"GLPI is the Information Resource-Manager with an additional Administration- Interface. You can use it to build up a database with an inventory for your company (computer, software, printers...). It has enhanced functions to make the daily life for the administrators easier, like a job-tracking-system with mail-notification and methods to build a database with basic information about your network-topology."

The principal functionalities of the application are :

1. the precise inventory of all the technical resources. All their characteristics will be stored in a database.
1. management and the history of the maintenance actions and the bound procedures. This application is dynamic and is directly connected to the users who can post requests to the technicians. An interface thus authorizes the latter with if required preventing the service of maintenance and indexing a problem encountered with one of the technical resources to which they have access.

### [Skin GLPI](https://sites.google.com/site/airtecmx/glpi---skins)
Two variants of graphic templates to change the appearance of the ticketing system.
#### Grey
![Grey](https://sites.google.com/site/airtecmx/glpi---skins/greyskinforglpi084-includesimagesscriptsandcssfiles-/01.png?attredirects=0)

#### Black
![Black](https://sites.google.com/site/airtecmx/glpi---skins/blackgreenskinforglpi084/black2.png.1379563631780.png?attredirects=0)

#### Default
![Default](http://s20.postimage.org/66nbf46gd/GLPI.jpg)

Requirements
------------
#### Cookbooks:

- yum-epel - https://github.com/opscode-cookbooks/yum-epel
- apache2 - https://github.com/onehealth-cookbooks/apache2
- mysql - https://github.com/opscode-cookbooks/mysql
- php - https://github.com/opscode-cookbooks/php
- subversion - https://github.com/opscode-cookbooks/subversion
- database - https://github.com/opscode-cookbooks/database

The following platforms and versions are tested and supported using Opscode's test-kitchen.

- CentOS 5.8, 6.3

The following platform families are supported in the code, and are assumed to work based on the successful testing on Ubuntu and CentOS.


- Red Hat (rhel)
- Fedora
- Amazon Linux

Recipes
-------
#### glpi:default
##### Basic Config
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>node[:glpi][:version]</tt></td>
    <td>String</td>
    <td>Tag version for install</td>
    <td><tt>0.84.5</tt></td>
  </tr>
  <tr>
    <td><tt>node[:glpi][:url]</tt></td>
    <td>String</td>
    <td>url for tag svn repo</td>
    <td><tt>https://forge.indepnet.net/svn/glpi/tags</tt></td>
  </tr>
  <tr>
    <td><tt>node[:glpi][:path]</tt></td>
    <td>String</td>
    <td>Install Path for glpi</td>
    <td><tt>/usr/share/glpi</tt></td>
  </tr>
  <tr>
    <td><tt>node[:glpi][:db_name]</tt></td>
    <td>String</td>
    <td>Database name for glpi</td>
    <td><tt>glpi</tt></td>
  </tr>
  <tr>
    <td><tt>node[:glpi][:db_user]</tt></td>
    <td>String</td>
    <td>username for glpi database</td>
    <td><tt>glpi</tt></td>
  </tr>
  <tr>
    <td><tt>node[:glpi][:db_password]</tt></td>
    <td>String</td>
    <td>user password for glpi database</td>
    <td><tt>password</tt></td>
  </tr>
  <tr>
    <td><tt>node[:glpi][:server_name]</tt></td>
    <td>String</td>
    <td>Server Name tag for Apache conf</td>
    <td><tt>tickets</tt></td>
  </tr>
  <tr>
    <td><tt>node[:glpi][:server_alias]</tt></td>
    <td>String</td>
    <td>Server alias tag for Apache conf</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>node[:glpi][:glpi_pass]</tt></td>
    <td>String</td>
    <td>Default password for glpi,tech,post-only and normal</td>
    <td><tt>default</tt></td>
  </tr>
  <tr>
    <td><tt>node[:glpi][:theme]</tt></td>
    <td>String</td>
    <td>Default, black or grey are acepted values</td>
    <td><tt>default</tt></td>
  <tr>
    <td><tt>node[:glpi][:mailcollector]</tt></td>
    <td>array</td>
    <td>Configure n mail collectors</td>
    <td><tt>n/a</tt></td>
  </tr>
</table>

#####Config Auth Active Directory
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Example</th>
  </tr>
  <tr>
    <td><tt>default[:glpi][:ad][:enable]</tt></td>
    <td>boolean</td>
    <td>Enable/Disable Active Directory Auth</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>default[:glpi][:ad][:domain]</tt></td>
    <td>String</td>
    <td>Domain name</td>
    <td><tt>CONTOSO</tt></td>
  </tr>
  <tr>
    <td><tt>default[:glpi][:ad][:PDC]</tt></td>
    <td>String</td>
    <td>PDC IP or DNS, ldap:// or ldaps:// (Optional)</td>
    <td><tt>ldap://192.168.0.1</tt></td>
  </tr>
  <tr>
    <td><tt>default[:glpi][:ad][:basedn]</tt></td>
    <td>String</td>
    <td>DN Base for search users</td>
    <td><tt>dc=contoso,dc=com</tt></td>
  </tr>
  <tr>
    <td><tt>default[:glpi][:ad][:binddn]</tt></td>
    <td>String</td>
    <td>user for bind DN</td>
    <td><tt>user@contoso.com</tt></td>
  </tr>
  <tr>
    <td><tt>default[:glpi][:ad][:bindpassword]</tt></td>
    <td>String</td>
    <td>password of user for bind DN</td>
    <td><tt>password</tt></td>
  </tr>
  <tr>
    <td><tt>default[:glpi][:ad][:port]</tt></td>
    <td>string</td>
    <td>Port of Active directory</td>
    <td><tt>389</tt></td>
  </tr>
</table>

#### glpi:theme
not config required

##### Examples of mail collector array
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Example</th>
  </tr>
  <tr>
    <td><tt>default[:glpi][:mailcollector][#{name}][host]</tt></td>
    <td>string</td>
    <td>conection string for mail server</td>
    <td><tt>{mail.contoso.com:110/pop/ssl}</tt></td>
  </tr>
  <tr>
    <td><tt>default[:glpi][:mailcollector][#{name}][login]</tt></td>
    <td>String</td>
    <td>user email</td>
    <td><tt>user@contoso.com</tt></td>
  </tr>
  <tr>
    <td><tt>default[:glpi][:mailcollector][#{name}][:filesize_max]</tt></td>
    <td>Int</td>
    <td>Max filesize in MB</td>
    <td><tt>10</tt></td>
  </tr>
  <tr>
    <td><tt>default[:glpi][:mailcollector][#{name}][:password]</tt></td>
    <td>String</td>
    <td>Password of mail user</td>
    <td><tt>secret</tt></td>
  </tr>
</table>

```json
"default_attributes": {
  "glpi": {
    "mailcollector": {
      "test@contoso.com": {
        "host": "{mail.contoso.com:110/pop/ssl}INBOX",
        "login': "test@contoso.com",
        "filesize_max": 10,
        "password': "test"
      }
    }
  }
}
```
Example of hots string conection for mailcollector:

######Basic
```
{mail.contoso.com/pop} #pop config
{mail.contoso.com/imap} #imap config
```
######Advance
```
{mail.contoso.com:110/pop/ssl/novalidate-cert/tsl/debug}
#pop, ssl, no check certificate config, tsl enable, debug enable
```

Usage
-----
#### glpi::default
Just include `glpi` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[glpi]"
  ]
}
```

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

[More details](https://github.com/psyreactor/glpi-cookbook/blob/master/CONTRIBUTING.md)

License and Authors
-------------------
Authors:
Lucas Mariani (Psyreactor)
- [marianiluca@gmail.com](mailto:marianiluca@gmail.com)
- [https://github.com/psyreactor](https://github.com/psyreactor)

Martin Cheveste (TinchosOS)
- [mjcheveste@gmail.com](mailto:mjcheveste@gmail.com)
