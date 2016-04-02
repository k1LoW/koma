require 'thor'
require 'json'

include Specinfra::Helper::Set

module Koma
  class CLI < Thor
    desc 'ssh', 'stdout server inventory'
    option :key,
           type: :string,
           banner: '<key1,key2,..>',
           desc: 'inventory keys',
           aliases: :k
    option :identity_file,
           type: :string,
           banner: '<identity_file>',
           desc: 'identity file',
           aliases: :i
    option :port,
           type: :numeric,
           banner: '<port>',
           desc: 'port',
           aliases: :p
    def ssh(host)
      user, host = host.split('@') if host.include?('@')
      set :backend, :ssh
      set :host, host
      set :request_pty, true
      ssh_options = Net::SSH::Config.for(host)
      ssh_options[:user] = user if user
      ssh_options[:keys] = [options[:identity_file]] if options[:identity_file]
      ssh_options[:port] = options[:port] if options[:port]
      set :ssh_options, ssh_options
      puts JSON.pretty_generate out(options[:key])
    end

    desc 'exec', 'stdout local inventory'
    option :key,
           type: :string,
           banner: '<key1,key2,..>',
           desc: 'inventory keys',
           aliases: :k
    def exec
      set :backend, :exec
      puts JSON.pretty_generate out(options[:key])
    end

    desc 'keys', 'server inventory keys'
    def keys
      inventory_keys.each do |key|
        puts key
      end
    end

    private

    def inventory_keys
      Specinfra::HostInventory.inventory_keys
    end

    def out(key = nil)
      out = {}
      keys = if key.nil?
               inventory_keys
             else
               key.split(',')
             end
      keys.each do |k|
        begin
          out[k] = Specinfra.backend.host_inventory[k]
        rescue NotImplementedError
          out[k] = nil
        end
      end
      out
    end
  end
end
