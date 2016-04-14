require 'spec_helper'

str = <<-EOH
abrt-ccpp\t0:off\t1:off\t2:off\t3:off\t4:off\t5:off\t6:off
abrt-oops\t0:off\t1:off\t2:off\t3:off\t4:off\t5:off\t6:off
abrtd\t0:off\t1:off\t2:off\t3:off\t4:off\t5:off\t6:off
acpid\t0:off\t1:off\t2:on\t3:on\t4:on\t5:on\t6:off
atd\t0:off\t1:off\t2:off\t3:on\t4:on\t5:on\t6:off
auditd\t0:off\t1:off\t2:off\t3:off\t4:off\t5:off\t6:off
blk-availability\t0:off\t1:on\t2:on\t3:on\t4:on\t5:on\t6:off
cpuspeed\t0:off\t1:on\t2:off\t3:off\t4:off\t5:off\t6:off
crond\t0:off\t1:off\t2:on\t3:on\t4:on\t5:on\t6:off
haldaemon\t0:off\t1:off\t2:off\t3:off\t4:off\t5:off\t6:off
htcacheclean\t0:off\t1:off\t2:off\t3:off\t4:off\t5:off\t6:off
httpd\t0:off\t1:off\t2:on\t3:on\t4:on\t5:on\t6:off
ip6tables\t0:off\t1:off\t2:off\t3:off\t4:off\t5:off\t6:off
iptables\t0:off\t1:off\t2:on\t3:on\t4:on\t5:on\t6:off
irqbalance\t0:off\t1:off\t2:off\t3:on\t4:on\t5:on\t6:off
kdump\t0:off\t1:off\t2:off\t3:off\t4:off\t5:off\t6:off
lvm2-monitor\t0:off\t1:on\t2:off\t3:off\t4:off\t5:off\t6:off
mdmonitor\t0:off\t1:off\t2:off\t3:off\t4:off\t5:off\t6:off
messagebus\t0:off\t1:off\t2:off\t3:off\t4:off\t5:off\t6:off
mysqld\t0:off\t1:off\t2:on\t3:on\t4:on\t5:on\t6:off
netconsole\t0:off\t1:off\t2:off\t3:off\t4:off\t5:off\t6:off
netfs\t0:off\t1:off\t2:off\t3:off\t4:off\t5:off\t6:off
network\t0:off\t1:off\t2:on\t3:on\t4:on\t5:on\t6:off
EOH

describe Specinfra::HostInventory::Parser::Redhat::Base::Service do
  describe 'Example of CentOS Linux release 6.6' do
    backend = Specinfra::Helper::DetectOs::Redhat.new(:exec)
    it 'Should parse' do
      allow(backend).to receive(:command) {
        CommandFactory.new({ family: 'redhat', release: '6.6' })
      }
      allow(backend).to receive(:run_command) {
        CommandResult.new(:stdout => '', :exit_status => 0)
      }
      allow(backend.command).to receive(:get) {
        CommandResult.new(:stdout => '', :exit_status => 0)
      }
      ret = Specinfra::HostInventory::Parser::Redhat::Base::Service.create(backend).parse(str)
      expect(ret).to include(
        'abrt-ccpp' => { :enabled => false, :running => true },
        'abrt-oops' => { :enabled => false, :running => true },
        'abrtd' => { :enabled => false, :running => true },
        'acpid' => { :enabled => true, :running => true },
        'atd' => { :enabled => true, :running => true },
        'auditd' => { :enabled => false, :running => true },
        'blk-availability' => { :enabled => true, :running => true },
        'cpuspeed' => { :enabled => false, :running => true },
        'crond' => { :enabled => true, :running => true },
        'haldaemon' => { :enabled => false, :running => true },
        'htcacheclean' => { :enabled => false, :running => true },
        'httpd' => { :enabled => true, :running => true },
        'ip6tables' => { :enabled => false, :running => true },
        'iptables' => { :enabled => true, :running => true },
        'irqbalance' => { :enabled => true, :running => true },
        'kdump' => { :enabled => false, :running => true },
        'lvm2-monitor' => { :enabled => false, :running => true },
        'mdmonitor' => { :enabled => false, :running => true },
        'messagebus' => { :enabled => false, :running => true },
        'mysqld' => { :enabled => true, :running => true },
        'netconsole' => { :enabled => false, :running => true },
        'netfs' => { :enabled => false, :running => true },
        'network' => { :enabled=>true, :running=>true }
      )
    end
  end
end
