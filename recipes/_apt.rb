#
# Author:: Seth Vargo (<sethvargo@gmail.com>)
# Recipe:: apt
#
# Copyright 2014 Chef Software, Inc.
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
#

execute 'apt-get update' do
  ignore_failure true
  notifies :run, 'execute[apt-cache gencaches]', :immediately
end

execute 'apt-cache gencaches' do
  ignore_failure true
  action :nothing
end

package 'software-properties-common'
package 'python-software-properties'

execute 'add-apt-repository[ppa:brightbox]' do
  command 'add-apt-repository ppa:brightbox/ruby-ng-experimental'
  notifies :run, 'execute[apt-get update]', :immediately
  not_if 'test -f /etc/apt/sources.list.d/brightbox-ruby-ng-experimental-precise.list -o -f /etc/apt/sources.list.d/brightbox-ruby-ng-experimental-trusty.list'
end
