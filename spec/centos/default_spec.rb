require_relative '../spec_helper'

describe 'glpi::default on Centos 6.5' do
  let(:chef_run) do
    ChefSpec::Runner.new(
      :platform => 'centos',
      :version => '6.5'
      ) do |node|
      node.set[:glpi][:version] = '0.84.5'
      node.set[:glpi][:url] = 'https://forge.indepnet.net/svn/glpi/tags'
      node.set[:glpi][:path] = '/usr/share/glpi'
      node.set[:glpi][:db_name] = 'glpi'
      node.set[:glpi][:db_user] = 'glpi'
      node.set[:glpi][:ad][:enable] = true
      node.set[:glpi][:mailcollector][:test][:host] = '{mail.contoso.com:110/pop/ssl}INBOX'
      node.set[:glpi][:mailcollector][:test][:login] = 'test@contoso.com'
      node.set[:glpi][:mailcollector][:test][:password] = 'password'
      node.set[:glpi][:mailcollector][:test][:filesize_max] = '10'
    end.converge('glpi::default')
  end

  let(:glpi_apache) { chef_run.template('/etc/httpd/sites-available/glpi.conf') }

  before do
    stub_command('which php').and_return(true)
    stub_command('mysql --user=glpi --password=password glpi -e "SELECT version FROM glpi_configs" | grep 0.84.5 -ci ').and_return(false)
    stub_command('mysql --user=glpi --password=password glpi -e "SELECT password FROM glpi_users" | grep 0915bd0a5c6e56d8f38ca2b390857d4949073f41 -ci ').and_return(true)
    stub_command('mysql --user=glpi --password=password glpi -e "SELECT * FROM glpi_authldaps" | grep CONTOSO').and_return(false)
    stub_command('mysql --user=glpi --password=password glpi -e "SELECT * FROM glpi_mailcollectors" | grep test').and_return(false)
  end

  it 'includes apache2 recipes' do
    expect(chef_run).to include_recipe('apache2::default')
    expect(chef_run).to include_recipe('apache2::mod_php5')
  end

  it 'includes mysql server recipe' do
    expect(chef_run).to include_recipe('mysql::server')
  end

  it 'includes php default recipe' do
    expect(chef_run).to include_recipe('php::default')
  end

  it 'includes svn default recipe' do
    expect(chef_run).to include_recipe('subversion::default')
  end

  it 'includes database mysql recipe' do
    expect(chef_run).to include_recipe('database::mysql')
  end

  it 'installs a package for php depens' do
    expect(chef_run).to install_package('php-ldap')
    expect(chef_run).to install_package('php-imap')
    expect(chef_run).to install_package('php-mysql')
    expect(chef_run).to install_package('php-mbstring')
  end

  it 'creates glpi directory' do
    expect(chef_run).to create_directory('/usr/share/glpi').with(
      user: 'apache',
      group: 'apache'
    )
  end

  it 'checkouts a subversion glpi repository' do
    expect(chef_run).to checkout_subversion('/usr/share/glpi').with(repository: 'https://forge.indepnet.net/svn/glpi/tags/GLPI_0.84.5')
  end

  it 'create database glpi' do
    expect(chef_run).to create_mysql_database('glpi')
  end

  it 'create user database glpi' do
    expect(chef_run).to grant_mysql_database_user('glpi')
  end

  it 'import glpi schema database' do
    expect(chef_run).to run_script('glpi_schema')
  end

  it 'change user glpi default password' do
    expect(chef_run).to query_mysql_database('glpi_password')
  end

  it 'created apache2 vhost ' do
    expect(chef_run).to create_template('/etc/httpd/sites-available/glpi.conf')
  end

  it 'created config database file ' do
    expect(chef_run).to create_template('/usr/share/glpi/config/config_db.php')
  end

  it 'sends a notification to services' do
    expect(glpi_apache).to notify('service[apache2]').to(:restart).delayed
  end

  it 'delete install file' do
    expect(chef_run).to delete_file('/usr/share/glpi/install/install.php')
  end

  it 'includes glpi theme recipe' do
    expect(chef_run).to include_recipe('glpi::theme')
  end

  it 'enable AD auth on glpi' do
    expect(chef_run).to query_mysql_database('glpi_AD')
  end

  it 'enable mailcollector on glpi' do
    expect(chef_run).to query_mysql_database('glpi_mail_test')
  end

end
