class Specinfra::HostInventory::Parser::Redhat::Base::Package < Specinfra::HostInventory::Parser::Linux::Package
  class << self
    def parse(cmd_ret)
      packages = {}
      lines = cmd_ret.split(/\n/)
      lines.each do |line|
        h = Hash[line.split("\t").map { |f| f.split(':', 2) }]
        idx = h['name']
        packages[idx] = h
      end
      packages
    end
  end
end
