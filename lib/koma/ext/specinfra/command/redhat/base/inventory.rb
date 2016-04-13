class Specinfra::Command::Redhat::Base::Inventory < Specinfra::Command::Linux::Base::Inventory
  class << self
    def get_service
      "chkconfig --list"
    end

    def get_package
      "rpm -qa --queryformat 'name:%{NAME}\tversion:%{VERSION}\trelease:%{RELEASE}\tarch:%{ARCH}\tinstalltime:%{INSTALLTIME}\tbuildtime:%{BUILDTIME}\n'"
    end
  end
end
