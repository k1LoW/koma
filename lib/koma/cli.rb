require 'thor'
require 'json'
require 'parallel'

include Specinfra::Helper::Set

module Koma
  class CLI < Thor
    desc 'ssh', 'stdout remote host inventory'
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
      if host.include?(',')
        list = host.split(',')
        results = Parallel.map(list, in_thread: 4) do |h|
          ssh_out(h, options)
        end
        arr = [list, results].transpose
        puts JSON.pretty_generate(Hash[*arr.flatten])
      else
        result = ssh_out(host, options)
        puts JSON.pretty_generate(result)
      end
    end

    desc 'exec', 'stdout local host inventory'
    option :key,
           type: :string,
           banner: '<key1,key2,..>',
           desc: 'inventory keys',
           aliases: :k
    def exec
      set :backend, :exec
      result = out(options[:key])
      puts JSON.pretty_generate(result)
    end

    desc 'keys', 'host inventory keys'
    def keys
      inventory_keys.each do |key|
        puts key
      end
    end

    private

    def inventory_keys
      Specinfra::HostInventory.inventory_keys
    end

    def ssh_out(host, options)
      user, host = host.split('@') if host.include?('@')
      set :backend, :ssh
      set :host, host
      set :request_pty, true
      ssh_options = Net::SSH::Config.for(host)
      ssh_options[:user] = user if user
      ssh_options[:keys] = [options[:identity_file]] if options[:identity_file]
      ssh_options[:port] = options[:port] if options[:port]
      set :ssh_options, ssh_options
      out(options[:key])
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
          out[k] = Specinfra.backend.host_inventory[k].inspect if k == 'ec2'
        rescue NotImplementedError
          out[k] = nil
        end
      end
      out
    end
  end
end
