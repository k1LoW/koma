require 'spec_helper'

str = <<-EOH
name:libndp\tversion:1.2\trelease:4.el7\tarch:x86_64\tinstalltime:1454045569\tbuildtime:1402354146
name:filesystem\tversion:3.2\trelease:20.el7\tarch:x86_64\tinstalltime:1454045531\tbuildtime:1439389384
name:dmidecode\tversion:2.12\trelease:9.el7\tarch:x86_64\tinstalltime:1454045569\tbuildtime:1447997958
name:ncurses-base\tversion:5.9\trelease:13.20130511.el7arch:noarch\tinstalltime:1454045535\tbuildtime:1402456336
name:bind-license\tversion:9.9.4\trelease:29.el7\tarch:noarch\tinstalltime:1454045569\tbuildtime:1448032358
name:dracut-network\tversion:033\trelease:359.el7arch:x86_64\tinstalltime:1454045570\tbuildtime:1448017425
name:bash\tversion:4.2.46\trelease:19.el7\tarch:x86_64\tinstalltime:1454045542\tbuildtime:1447995893
name:zlib\tversion:1.2.7\trelease:15.el7\tarch:x86_64\tinstalltime:1454045542\tbuildtime:1448010635
name:tuned\tversion:2.5.1\trelease:4.el7\tarch:noarch\tinstalltime:1454045571\tbuildtime:1448034038
name:libuuid\tversion:2.23.2\trelease:26.el7\tarch:x86_64\tinstalltime:1454045543\tbuildtime:1448023070
name:firewalld\tversion:0.3.9\trelease:14.el7\tarch:noarch\tinstalltime:1454045572\tbuildtime:1448022902
name:chkconfig\tversion:1.3.61\trelease:5.el7\tarch:x86_64\tinstalltime:1454045543\tbuildtime:1447996314
name:postfix\tversion:2.10.1\trelease:6.el7\tarch:x86_64\tinstalltime:1454045579\tbuildtime:1402364376
name:grep\tversion:2.20\trelease:2.el7\tarch:x86_64\tinstalltime:1454045543\tbuildtime:1448000049
EOH

describe Specinfra::HostInventory::Package do
  let(:host_inventory) { nil }
  describe 'Example of CentOS Linux release 7.2.1511' do
    ret = Specinfra::HostInventory::Package.new(host_inventory).parse(str)
    example do
      expect(ret).to include(
        'bash' => { 'name' => 'bash', 'version' => '4.2.46', 'release' => '19.el7', 'arch' => 'x86_64', 'installtime' => '1454045542', 'buildtime' => '1447995893' },
        'bind-license' => { 'name' => 'bind-license', 'version' => '9.9.4', 'release' => '29.el7', 'arch' => 'noarch', 'installtime' => '1454045569', 'buildtime' => '1448032358' },
        'chkconfig' => { 'name' => 'chkconfig', 'version' => '1.3.61', 'release' => '5.el7', 'arch' => 'x86_64', 'installtime' => '1454045543', 'buildtime' => '1447996314' },
        'dmidecode' => { 'name' => 'dmidecode', 'version' => '2.12', 'release' => '9.el7', 'arch' => 'x86_64', 'installtime' => '1454045569', 'buildtime' => '1447997958' },
        'dracut-network' => { 'name' => 'dracut-network', 'version' => '033', 'release' => '359.el7arch:x86_64', 'installtime' => '1454045570', 'buildtime' => '1448017425' },
        'filesystem' => { 'name' => 'filesystem', 'version' => '3.2', 'release' => '20.el7', 'arch' => 'x86_64', 'installtime' => '1454045531', 'buildtime' => '1439389384' },
        'firewalld' => { 'name' => 'firewalld', 'version' => '0.3.9', 'release' => '14.el7', 'arch' => 'noarch', 'installtime' => '1454045572', 'buildtime' => '1448022902' },
        'grep' => { 'name' => 'grep', 'version' => '2.20', 'release' => '2.el7', 'arch' => 'x86_64', 'installtime' => '1454045543', 'buildtime' => '1448000049' },
        'libndp' => { 'name' => 'libndp', 'version' => '1.2', 'release' => '4.el7', 'arch' => 'x86_64', 'installtime' => '1454045569', 'buildtime' => '1402354146' },
        'libuuid' => { 'name' => 'libuuid', 'version' => '2.23.2', 'release' => '26.el7', 'arch' => 'x86_64', 'installtime' => '1454045543', 'buildtime' => '1448023070' },
        'ncurses-base' => { 'name' => 'ncurses-base', 'version' => '5.9', 'release' => '13.20130511.el7arch:noarch', 'installtime' => '1454045535', 'buildtime' => '1402456336' },
        'postfix' => { 'name' => 'postfix', 'version' => '2.10.1', 'release' => '6.el7', 'arch' => 'x86_64', 'installtime' => '1454045579', 'buildtime' => '1402364376' },
        'tuned' => { 'name' => 'tuned', 'version' => '2.5.1', 'release' => '4.el7', 'arch' => 'noarch', 'installtime' => '1454045571', 'buildtime' => '1448034038' },
        'zlib' => { 'name' => 'zlib', 'version' => '1.2.7', 'release' => '15.el7', 'arch' => 'x86_64', 'installtime' => '1454045542', 'buildtime' => '1448010635' }
      )
    end
  end
end
