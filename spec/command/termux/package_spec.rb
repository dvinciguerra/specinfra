require 'spec_helper'

property[:os] = nil
set :os, :family => 'termux'

describe get_command(:check_package_is_installed, 'git') do
  it { should eq "dpkg-query -f '${Status}' -W git | grep -E '^(install|hold) ok installed$'" }
end

describe get_command(:check_package_is_installed, 'git', '2.45.0') do
  it { should eq "dpkg-query -f '${Status} ${Version}' -W git | grep -E '^(install|hold) ok installed 2\\.45\\.0$'" }
end

describe get_command(:install_package, 'git') do
  it { should eq "apt-get -y -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold'  install git" }
end

describe get_command(:install_package, 'git', '2.45.0') do
  it { should eq "apt-get -y -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold'  install git\\=2.45.0" }
end

describe get_command(:remove_package, 'git') do
  it { should eq 'apt-get -y  remove git' }
end
