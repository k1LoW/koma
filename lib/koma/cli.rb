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
    def ssh(host)
      user, host = host.split('@') if host.include?('@')
      set :backend, :ssh
      set :host, host
      set :request_pty, true
      ssh_options = Net::SSH::Config.for(host)
      ssh_options[:user] = user if user
      ssh_options[:keys] = [options[:identity_file]] if options[:identity_file]
      set :ssh_options, ssh_options
      puts JSON.pretty_generate out(options[:key])
    end

    desc 'keys', 'server inventory keys'
    def keys
      inventory_keys.each do |key|
        puts key
      end
    end

    def method_missing(name)
      ssh(name.to_s)
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
        inventory = Specinfra.backend.host_inventory[k]
        out[k] = inventory unless inventory.nil?
      end
      out
    end
  end
end
