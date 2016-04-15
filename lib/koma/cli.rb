require 'thor'
require 'json'
require 'yaml'

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
      backend = Koma::Backend::Ssh.new(host, options)
      puts JSON.pretty_generate(backend.gather)
    end

    desc 'exec', 'stdout local host inventory'
    option :key,
           type: :string,
           banner: '<key1,key2,..>',
           desc: 'inventory keys',
           aliases: :k
    def exec
      backend = Koma::Backend::Exec.new(nil, options)
      puts JSON.pretty_generate(backend.gather)
    end

    desc 'keys', 'host inventory keys'
    def keys
      Specinfra::HostInventory.inventory_keys.each do |key|
        puts key
      end
    end
  end
end
