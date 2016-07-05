class Specinfra::HostInventory::Parser::Redhat::V7::Service < Specinfra::HostInventory::Parser::Redhat::Base::Service
  class << self
    def parse(cmd_ret)
      services = {}
      lines = cmd_ret.split(/\n/)
      lines.each do |line|
        status = line.split(/ +/)
        next unless status.count == 2
        service = status[0].gsub(/\.service\z/, '')
        cmd = backend.command.get(:check_service_is_running, service)
        services[service] = {
          enabled: status[1].include?('enabled'),
          running: backend.run_command(cmd).success?
        }
      end
      services
    end
  end
end
