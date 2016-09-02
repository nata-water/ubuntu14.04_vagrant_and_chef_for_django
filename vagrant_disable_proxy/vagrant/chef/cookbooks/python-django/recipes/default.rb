#
# Cookbook Name:: python-django
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template "#{node["vagrant"]["home"]}/.bash_profile" do
    source ".bash_profile.erb"
    owner "#{node["vagrant"]["user"]}"
    group "#{node["vagrant"]["user"]}"
    mode "644"
end

bash "source ~/.bash_profile" do
    user "#{node["vagrant"]["user"]}"
    environment "HOME" => "#{node["vagrant"]["home"]}"
    code "source ~/.bash_profile"
end

apt_package "python-pip" do
    action :install
end

apt_package "git" do
    action :install
end

bash "install virtualenv" do 
    user "#{node["vagrant"]["user"]}"
    environment "HOME" => "#{node["vagrant"]["home"]}"
    code "sudo pip install virtualenv
end

bash "create virtualenv" do
    user node["vagrant"]["user"]
    environment "HOME" => "#{node["vagrant"]["home"]}"
    code "virtualenv ~/venv-chef"
end

bash "activate virtualenv and install django" do
    user node["vagrant"]["user"]
    environment "HOME" => "#{node["vagrant"]["home"]}"
    code "source ~/venv-chef/bin/activate && pip install"
end

#bash "configure git http proxy" do
#    user "#{node["vagrant"]["user"]}"
#    environment "HOME" => "#{node["vagrant"]["home"]}"
#    code "git config --global http.proxy $HTTP_PROXY"
#end

#bash "configure git https proxy" do
#    user "#{node["vagrant"]["user"]}"
#    environment "HOME" => "#{node["vagrant"]["home"]}"
#    code "git config --global https.proxy $HTTP_PROXY"
#end

bash "install pyenv" do
    user "#{node["vagrant"]["user"]}"
    environment "HOME" => "#{node["vagrant"]["home"]}"
    not_if { Dir.exists?("#{node["vagrant"]["home"]}/.pyenv") }
    code "git clone https://github.com/yyuu/pyenv.git ~/.pyenv"
end

bash "install python-build" do
    user "#{node["vagrant"]["user"]}"
    environment "HOME" => "#{node["vagrant"]["home"]}"
    not_if  { Dir.exists?("#{node["vagrant"]["home"]}/.pyenv/plugins/python-build") }
    code "git clone git://github.com/yyuu/pyenv.git ~/.pyenv/plugins && ~/.pyenv/plugins/install.sh"
end