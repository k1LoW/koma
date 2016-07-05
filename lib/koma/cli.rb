require 'thor'
require 'json'
require 'yaml'

module Koma
  class CLI < Thor
    class_option :version, type: :boolean, aliases: :V

    desc 'ssh <host1,host2,..>', 'stdout remote host inventory'
    option :key, type: :string, banner: '<key1,key2,..>', desc: 'inventory keys', aliases: :k
    option :yaml, type: :boolean, desc: 'stdout YAML', aliases: :Y
    option :identity_file, type: :string, banner: '<identity_file>', desc: 'identity file', aliases: :i
    option :port, type: :numeric, banner: '<port>', desc: 'port', aliases: :p
    Koma::HostInventory.disabled_keys.each do |key|
      option "enable-#{key}", type: :boolean, desc: "enable #{key}"
    end
    def ssh(host = nil)
      if host.nil?
        begin
          stdin = timeout(1) { $stdin.read }
        rescue Timeout::Error
        end
        ret = stdin.split("\n").select { |line| line =~ /^Host ([^\s\*]+)/ }.map do |line|
          line =~ /^Host ([^\s]+)/
          Regexp.last_match[1]
        end
        host = ret.join(',')
      end
      backend = Koma::Backend::Ssh.new(host, options)
      backend.stdin = stdin if stdin
      gathered = backend.gather
      if options[:yaml]
        puts YAML.dump(gathered)
      else
        puts JSON.pretty_generate(gathered)
      end
    end

    desc 'run-command <host1,host2,..> <command1> <command2> ...', 'run command on remote hosts'
    option :yaml, type: :boolean, desc: 'stdout YAML', aliases: :Y
    option :identity_file, type: :string, banner: '<identity_file>', desc: 'identity file', aliases: :i
    option :port, type: :numeric, banner: '<port>', desc: 'port', aliases: :p
    def run_command(host = nil, *commands)
      if host.nil?
        STDERR.puts 'ERROR: "koma run-command" was called with no arguments'
        STDERR.puts 'Usage: "koma run-command <host1,host2,..> <command>"'
        return
      end
      if commands.empty?
        commands = [host]
        begin
          stdin = timeout(1) { $stdin.read }
        rescue Timeout::Error
        end
        if stdin.nil?
          STDERR.puts 'ERROR: "koma run-commands" was called with no arguments'
          STDERR.puts 'Usage: "koma run-commands <host1,host2,..> <commands>"'
          return
        end
        ret = stdin.split("\n").select { |line| line =~ /^Host ([^\s\*]+)/ }.map do |line|
          line =~ /^Host ([^\s]+)/
          Regexp.last_match[1]
        end
        host = ret.join(',')
      end
      backend = Koma::Backend::Ssh.new(host, options)
      backend.stdin = stdin if stdin
      gathered = backend.run_commands(commands)
      if options[:yaml]
        puts YAML.dump(gathered)
      else
        puts JSON.pretty_generate(gathered)
      end
    end

    desc 'exec', 'stdout local host inventory'
    option :key, type: :string, banner: '<key1,key2,..>', desc: 'inventory keys', aliases: :k
    option :yaml, type: :boolean, desc: 'stdout YAML', aliases: :Y
    Koma::HostInventory.disabled_keys.each do |key|
      option "enable-#{key}", type: :boolean, desc: "enable #{key}"
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

    def help(command = nil)
      if options[:version]
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
