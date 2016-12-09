#
# Cookbook Name:: java
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.


execute 'create_oracle_java_folder' do
  command  'mkdir -p /var/www/html/oracle-java'
  creates  '/var/www/html/oracle-java'
end

execute 'download_oracle_rpm' do
  command 'wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u112-b15/jdk-8u112-linux-x64.rpm"'
  not_if { ::File.exist?('/var/www/html/oracle-java/jdk-8u112-linux-x64.rpm') }
end

execute 'move_jdk_to_oracle_java_folder' do
  command 'mv jdk*.rpm /var/www/html/oracle-java/'
  creates '/var/www/html/oracle-java/jdk-8u112-linux-x64.rpm'
end

package 'createrepo'

execute 'createrepo_oracle_java' do
  command 'createrepo /var/www/html/oracle-java'
  creates '/var/www/html/oracle-java/repodata'
end

yum_repository 'oracle-java' do
  description 'jdk1.8.0_112'
  baseurl 'file:///var/www/html/oracle-java'
  gpgcheck false
  action :create
end

include_recipe 'java::default'
#
# Cookbook Name:: java8
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
