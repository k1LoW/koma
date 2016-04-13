class Specinfra::Command::Redhat::V7::Inventory < Specinfra::Command::Redhat::Base::Inventory
  class << self
    def get_service
      "systemctl list-unit-files --quiet -t service | cat"
    end
  end
end
