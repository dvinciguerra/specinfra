require 'spec_helper'
require 'specinfra/helper/detect_os/termux'

describe Specinfra::Helper::DetectOs::Termux do
  termux = Specinfra::Helper::DetectOs::Termux.new(Specinfra.backend)

  it 'Should detect termux and get release from termux-tools package.' do
    allow(termux).to receive(:run_command).with('test -d /data/data/com.termux/files/usr') {
      CommandResult.new(:stdout => '', :exit_status => 0)
    }
    allow(termux).to receive(:run_command).with('command -v pkg >/dev/null 2>&1') {
      CommandResult.new(:stdout => '', :exit_status => 0)
    }
    allow(termux).to receive(:run_command).with("dpkg-query -f '${Version}' -W termux-tools") {
      CommandResult.new(:stdout => "1.2.3\n", :exit_status => 0)
    }
    expect(termux.detect).to include(
      :family  => 'termux',
      :release => '1.2.3'
    )
  end

  it 'Should detect termux and fallback to TERMUX_VERSION when package query fails.' do
    allow(termux).to receive(:run_command).with('test -d /data/data/com.termux/files/usr') {
      CommandResult.new(:stdout => '', :exit_status => 0)
    }
    allow(termux).to receive(:run_command).with('command -v pkg >/dev/null 2>&1') {
      CommandResult.new(:stdout => '', :exit_status => 0)
    }
    allow(termux).to receive(:run_command).with("dpkg-query -f '${Version}' -W termux-tools") {
      CommandResult.new(:stdout => '', :exit_status => 1)
    }
    allow(termux).to receive(:run_command).with('echo $TERMUX_VERSION') {
      CommandResult.new(:stdout => "0.118.0\n", :exit_status => 0)
    }
    expect(termux.detect).to include(
      :family  => 'termux',
      :release => '0.118.0'
    )
  end

  it 'Should return nil when not running inside termux.' do
    allow(termux).to receive(:run_command).with('test -d /data/data/com.termux/files/usr') {
      CommandResult.new(:stdout => '', :exit_status => 1)
    }
    expect(termux.detect).to be_nil
  end
end
