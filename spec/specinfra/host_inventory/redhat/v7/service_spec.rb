require 'spec_helper'

str = <<-EOH
UNIT FILE                                   STATE
auditd.service                              enabled
autovt@.service                             disabled
blk-availability.service                    disabled
brandbot.service                            static
console-getty.service                       disabled
console-shell.service                       disabled
container-getty@.service                    static
cpupower.service                            disabled
crond.service                               enabled
dbus-org.freedesktop.hostname1.service      static
dbus-org.freedesktop.locale1.service        static
dbus-org.freedesktop.login1.service         static
dbus-org.freedesktop.machine1.service       static
dbus-org.freedesktop.network1.service       invalid
dbus-org.freedesktop.NetworkManager.service enabled
dbus-org.freedesktop.nm-dispatcher.service  enabled

153 unit files listed.
EOH

describe Specinfra::HostInventory::Parser::Redhat::V7::Service do
  describe 'Example of CentOS Linux release 7.2.1511' do
    backend = Specinfra::Helper::DetectOs::Redhat.new(:exec)
    it 'Should parse' do
      allow(backend).to receive(:command) {
        CommandFactory.new({ family: 'redhat', release: '7.2.1511' })
      }
      allow(backend).to receive(:run_command) {
        CommandResult.new(:stdout => '', :exit_status => 0)
      }
      allow(backend.command).to receive(:get) {
        CommandResult.new(:stdout => '', :exit_status => 0)
      }
      ret = Specinfra::HostInventory::Parser::Redhat::V7::Service.create(backend).parse(str)
      expect(ret).to include(
        'auditd' => { :enabled => true, :running => true },
        'autovt@' => { :enabled => false, :running => true },
        'blk-availability' => { :enabled => false, :running => true },
        'brandbot' => { :enabled => false, :running => true },
        'console-getty' => { :enabled => false, :running => true },
        'console-shell' => { :enabled => false, :running => true },
        'container-getty@' => { :enabled => false, :running => true },
        'cpupower' => { :enabled => false, :running => true },
        'crond' => { :enabled => true, :running => true },
        'dbus-org.freedesktop.NetworkManager' => { :enabled => true, :running => true },
        'dbus-org.freedesktop.hostname1' => { :enabled => false, :running => true },
        'dbus-org.freedesktop.locale1' => { :enabled => false, :running => true },
        'dbus-org.freedesktop.login1' => { :enabled => false, :running => true },
        'dbus-org.freedesktop.machine1' => { :enabled => false, :running => true },
        'dbus-org.freedesktop.network1' => { :enabled => false, :running => true },
        'dbus-org.freedesktop.nm-dispatcher' => { :enabled => true, :running=>true }
      )
    end
  end
end
