#
# Cookbook Name:: git
# Recipe:: default
#
# Copyright 2008-2009, Opscode, Inc.
#
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

case node[:platform]
when "debian", "ubuntu"
  package "git-core"
when "centos","redhat","scientific","fedora"
  case node[:platform_version].to_i
  when 5
    include_recipe "yum::epel"
  end
  package "git"
when "solaris2","smartos"
  # TODO when chef/ohai official releases recognize smartos, remove "solaris2"
  execute "install git with pkgin" do
    command "pkgin -y install scmgit"
    not_if "pkgin list | grep scmgit"
  end
else
  package "git"
end
