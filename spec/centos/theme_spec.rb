require_relative '../spec_helper'

describe 'glpi::theme on Centos 6.5' do
  let(:chef_run) do
    ChefSpec::Runner.new(
      :platform => 'centos',
      :version => '6.5'
      ) do |node|
      node.set[:glpi][:selected] = 'grey'
    end.converge('glpi::theme')
  end

  it 'installs a package for unzip theme' do
    expect(chef_run).to install_package('unzip')
  end

  it 'download a gray skin glpi' do
    expect(chef_run).to create_remote_file_if_missing("#{Chef::Config[:file_cache_path]}/grey.skin.zip")
  end

  it 'backup theme default for glpi' do
    expect(chef_run).to run_script('theme_backup')
  end

  it 'install theme for glpi' do
    expect(chef_run).to run_script('theme_build')
  end

end

describe 'glpi::theme default on Centos 6.5' do
  let(:chef_run) do
    ChefSpec::Runner.new(
      :platform => 'centos',
      :version => '6.5'
      ) do |node|
      node.set[:glpi][:selected] = 'default'
    end.converge('glpi::theme')
  end

  before do
    ::Dir.stub(:exist?).with('/usr/share/glpi/bk').and_return(true)
  end

  it 'restore default theme for glpi' do
    expect(chef_run).to run_script('theme_default')
  end

  it 'delete bk directory' do
    expect(chef_run).to delete_directory('/usr/share/glpi/bk')
  end

end
