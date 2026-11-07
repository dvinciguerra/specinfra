require 'spec_helper'
require 'specinfra/helper/detect_os/termux'

describe Specinfra::Helper::DetectOs::Termux do
  subject(:termux) { described_class.new(Specinfra.backend) }

  it 'detects Termux and its version' do
    allow(termux).to receive(:run_command).with('echo $TERMUX_VERSION') {
      CommandResult.new(:stdout => "0.118.0\n", :exit_status => 0)
    }
    allow(termux).to receive(:run_command).with('file /data/data/com.termux/files/usr/bin/pkg') {
      CommandResult.new(:stdout => "...: POSIX shell script\n", :exit_status => 0)
    }

    expect(termux.detect).to eq(:family => 'termux', :release => '0.118.0')
  end

  it 'does not detect Termux when TERMUX_VERSION is unavailable' do
    allow(termux).to receive(:run_command).with('echo $TERMUX_VERSION') {
      CommandResult.new(:stdout => "", :exit_status => 1)
    }

    expect(termux.detect).to be_nil
  end

  it 'does not identify Termux when pkg is unavailable' do
    allow(termux).to receive(:run_command).with('echo $TERMUX_VERSION') {
      CommandResult.new(:stdout => "0.118.0\n", :exit_status => 0)
    }
    allow(termux).to receive(:run_command).with('file /data/data/com.termux/files/usr/bin/pkg') {
      CommandResult.new(:stdout => "", :exit_status => 1)
    }

    expect(termux.detect).to eq(:family => nil, :release => '0.118.0')
  end
end
