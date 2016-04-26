require 'parallel'
require 'sconb'

module Koma
  module Backend
    class Ssh < Base
      attr_accessor :stdin

      def gather
        if host.include?(',')
          list = host.split(',').uniq
          results = Parallel.map(list) do |h|
            gather_via_ssh(h, options)
          end
          arr = [list, results].transpose
          result = Hash[*arr.flatten]
        else
          result = gather_via_ssh(host, options)
        end
        result
      end

      def gather_via_ssh(host, options)
        user, host = host.split('@') if host.include?('@')
        set :backend, :ssh
        set :host, host
        set :request_pty, true
        if stdin
          parsed = Sconb::SSHConfig.parse(stdin, host, {})
          ssh_options = Net::SSH::Config.translate(Hash[parsed[host].map { |k, v| [k.downcase, v] }])
        else
          ssh_options = Net::SSH::Config.for(host)
          ssh_options[:user] = user if user
          ssh_options[:keys] = [options[:identity_file]] if options[:identity_file]
          ssh_options[:port] = options[:port] if options[:port]
        end

        set :ssh_options, ssh_options
        out(options[:key])
      end
    end
  end
end
