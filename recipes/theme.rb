# Encoding: utf-8
#
# Cookbook Name:: glpi
# Recipe:: theme
#
# Copyright 2014, Mariani Lucas
# Copyright 2014, Cheveste Martin
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
case node[:glpi][:selected]
when 'grey', 'black'
  package 'unzip' do
    action :install
  end

  remote_file "#{Chef::Config[:file_cache_path]}/#{node[:glpi][:theme][:name]}.zip" do
    action :create_if_missing
    owner 'root'
    group 'root'
    mode '0644'
    source node[:glpi][:theme][:url]
  end

  script 'theme_backup' do
    interpreter 'bash'
    user 'root'
    cwd node[:glpi][:path]
    code <<-EOH
      mkdir bk;
      cp -R #{node[:glpi][:path]}/pics bk;
      cp -R #{node[:glpi][:path]}/inc bk;
      cp -R #{node[:glpi][:path]}/css bk;
      cp -R #{node[:glpi][:path]}/lib/extjs bk;
      cp -R #{node[:glpi][:path]}/scripts bk
    EOH
    not_if { ::Dir.exist?("#{node[:glpi][:path]}/bk") }
  end

  script 'theme_build' do
    interpreter 'bash'
    user 'root'
    cwd Chef::Config[:file_cache_path]
    code <<-EOH
      unzip #{node[:glpi][:theme][:name]}.zip -d #{node[:glpi][:theme][:name]};
      cd #{node[:glpi][:theme][:name]};
      \\cp -R pics #{node[:glpi][:path]};
      \\cp html.class.php #{node[:glpi][:path]}/inc/;
      \\cp ext-all.css #{node[:glpi][:path]}/lib/extjs/resources/css/;
      \\cp *.css #{node[:glpi][:path]}/css/;
      \\cp *.js #{node[:glpi][:path]}/scripts
    EOH
  end

when 'default'

  script 'theme_default' do
    interpreter 'bash'
    user 'root'
    cwd node[:glpi][:path]
    code <<-EOH
      mv bk/pics/* pics/;
      mv bk/inc/* inc/;
      mv bk/css/* css/;
      mv bk/extjs/resources/css/* lib/extjs/resources/css/;
      mv bk/scripts/* scripts
    EOH
    only_if { ::Dir.exist?("#{node[:glpi][:path]}/bk") }
  end

  directory "#{node[:glpi][:path]}/bk" do
    owner 'root'
    group 'root'
    mode '0755'
    action :delete
    recursive true
  end

end
