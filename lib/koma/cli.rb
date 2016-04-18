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
    option :yaml,
           type: :boolean,
           desc: 'stdout YAML',
           aliases: :y
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
    Koma::HostInventory.disabled_keys.each do |key|
      option "with-#{key}",
             type: :boolean,
             desc: "enable #{key}"
    end
    def ssh(host)
      backend = Koma::Backend::Ssh.new(host, options)
      if options[:yaml]
        puts YAML.dump(backend.gather)
      else
        puts JSON.pretty_generate(backend.gather)
      end
    end

    desc 'exec', 'stdout local host inventory'
    option :key,
           type: :string,
           banner: '<key1,key2,..>',
           desc: 'inventory keys',
           aliases: :k
    option :yaml,
           type: :boolean,
           desc: 'stdout YAML',
           aliases: :y
    Koma::HostInventory.disabled_keys.each do |key|
      option "with-#{key}",
             type: :boolean,
             desc: "enable #{key}"
    end
    def exec
      backend = Koma::Backend::Exec.new(nil, options)
      if options[:yaml]
        puts YAML.dump(backend.gather)
      else
        puts JSON.pretty_generate(backend.gather)
      end
    end

    desc 'keys', 'host inventory keys'
    def keys
      Koma::HostInventory.all_inventory_keys.each do |key|
        key += ' (disabled)' if Koma::HostInventory.disabled_keys.include?(key)
        puts key
      end
    end

    option :version, type: :boolean, aliases: :v
    def help(version = nil)
      if version
        puts Koma::VERSION
      else
        super
      end
    end

    def method_missing(command)
      message = <<-EOH

  ((     ))
((  _____  ))
(U  ●   ●  U)
  ((  ●  ))  < Could not find command "#{command}".

EOH
      puts message
    end
  end
end
