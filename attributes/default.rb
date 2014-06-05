default[:glpi][:version] = '0.84.5'
default[:glpi][:url] = 'https://forge.indepnet.net/svn/glpi/tags'
default[:glpi][:path] = '/usr/share/glpi'
default[:glpi][:db_name] = 'glpi'
default[:glpi][:db_user] = 'glpi'
default[:glpi][:db_password] = 'password'
default[:glpi][:server_name] = 'tickets'
default[:glpi][:server_alias] = nil
default[:glpi][:glpi_pass] = 'default'
default[:glpi][:selected] = 'default' # default , grey or black

# AD auth config

default[:glpi][:ad][:enable] = true
default[:glpi][:ad][:domain] = 'CONTOSO'
default[:glpi][:ad][:pdc] = 'ldap://192.168.0.1'
default[:glpi][:ad][:basedn] = 'dc=contoso, dc=com'
default[:glpi][:ad][:binduser] = 'user@contoso.com.ar'
default[:glpi][:ad][:bindpassword] = 'GLadmin.3399'
default[:glpi][:ad][:port] = '389'
