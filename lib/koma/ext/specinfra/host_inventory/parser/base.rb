class Specinfra::HostInventory::Parser::Base
  class << self
    attr_reader :backend

    def create(backend)
      @backend = backend
      self
    end

    def parse(cmd_ret)
      cmd_ret
    end
  end
end
