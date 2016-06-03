class Specinfra::Command::Base::Inventory < Specinfra::Command::Base
  class << self
    def get_group
      'getent group'
    end
  end
end
