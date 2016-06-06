module Specinfra
  class HostInventory
    class Package < Base
      def get
        cmd = backend.command.get(:get_inventory_package)
        ret = backend.run_command(cmd)
        if ret.success?
          parse(ret.stdout)
        else
          nil
        end
      end

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
end
