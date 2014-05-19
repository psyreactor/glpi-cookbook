require_relative 'spec_helper'

describe package('php-ldap') do
  it { should be_installed }
end

describe package('php-imap') do
  it { should be_installed }
end

describe package('php-mysql') do
  it { should be_installed }
end

describe file('/usr/share/glpi') do
  it { should be_directory }
end

describe command('mysql --user=root --password=ilikerandompasswords -e "SHOW DATABASES" | grep glpi -ci') do
	it { should return_stdout '1' }
end

describe command('mysql --user=glpi --password=password -e "SHOW DATABASES" | grep glpi -ci') do
	it { should return_stdout '1' }
end

describe command('mysql --user=glpi --password=password glpi -e "SELECT version FROM glpi_configs" | grep 0.84.5 -ci') do
	it { should return_stdout '1' }
end