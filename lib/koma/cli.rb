require 'thor'
require 'json'

include Specinfra::Helper::Set

module Koma
  class CLI < Thor
    desc 'ssh', 'stdout server inventory'
    def ssh(host)
      user, host = host.split('@') if host.include?('@')
      set :backend, :ssh
      set :host, host
      set :request_pty, true
      options = Net::SSH::Config.for(host)
      options[:user] = user if user
      set :ssh_options, options
      puts JSON.pretty_generate out
    end

    private

    def out
      out = {}
      Specinfra::HostInventory.inventory_keys.each do |key|
        inventory = Specinfra.backend.host_inventory[key]
        out[key] = inventory unless inventory.nil?
      end
      out
    end
  end
end
