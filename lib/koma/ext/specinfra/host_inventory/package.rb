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
        parser.get('package').parse(cmd_ret)
      end
    end
  end
end
