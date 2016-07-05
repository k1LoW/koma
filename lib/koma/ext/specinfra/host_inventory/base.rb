module Specinfra
  class HostInventory
    class Base
      def parser
        Specinfra::HostInventory::ParserFactory.instance
      end
    end
  end
end
