module Specinfra
  class HostInventory
    class Service < Base
      def get
        cmd = backend.command.get(:get_inventory_service)
        ret = backend.run_command(cmd)
        if ret.success?
          parse(ret.stdout)
        else
          nil
        end
      end

      def parse(cmd_ret)
        parser = create_parser_class('service')
        parser.parse(cmd_ret)
      end
    end
  end
end
