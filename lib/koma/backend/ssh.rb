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

      def run_command(command)
        if host.include?(',')
          list = host.split(',').uniq
          results = Parallel.map(list) do |h|
            run_command_via_ssh(h, options, command)
          end
          arr = [list, results].transpose
          result = Hash[*arr.flatten]
        else
          result = run_command_via_ssh(host, options, command)
        end
        result
      end

      def gather_via_ssh(host, options)
        set :ssh_options, build_ssh_options(host, options)
        out(options[:key])
      end

      def run_command_via_ssh(host, options, command)
        set :ssh_options, build_ssh_options(host, options)
        result = Specinfra.backend.run_command(command)
        { command =>
          {
            exit_signal: result.exit_signal,
            exit_status: result.exit_status,
            stderr: result.stderr,
            stdout: result.stdout
          }
        }
      end

      private

      def build_ssh_options(host, options)
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
        ssh_options
      end
    end
  end
end
