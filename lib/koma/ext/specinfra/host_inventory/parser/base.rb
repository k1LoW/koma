class Specinfra::HostInventory::Parser::Base
  class << self
    def backend
      @backend
    end

    def create(backend)
      @backend = backend
      self
    end

    def parse(cmd_ret)
      cmd_ret
    end
  end
end
