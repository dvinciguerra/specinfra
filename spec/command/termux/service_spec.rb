require 'spec_helper'

property[:os] = nil
set :os, :family => 'termux'

describe get_command(:check_service_is_enabled, 'sshd') do
  it { should eq 'test -e "$PREFIX/var/service/sshd"' }
end

describe get_command(:check_service_is_running, 'sshd') do
  it { should eq "sv status sshd | grep -q '^run:'" }
end

describe get_command(:enable_service, 'sshd') do
  it { should eq 'sv-enable sshd' }
end

describe get_command(:disable_service, 'sshd') do
  it { should eq 'sv-disable sshd' }
end

describe get_command(:start_service, 'sshd') do
  it { should eq 'sv up sshd' }
end

describe get_command(:stop_service, 'sshd') do
  it { should eq 'sv down sshd' }
end

describe get_command(:restart_service, 'sshd') do
  it { should eq 'sv restart sshd' }
end

describe get_command(:reload_service, 'sshd') do
  it { should eq 'sv hup sshd' }
end
