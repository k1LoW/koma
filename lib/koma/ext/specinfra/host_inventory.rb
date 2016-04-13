require 'koma/ext/specinfra/host_inventory/base'
require 'koma/ext/specinfra/host_inventory/parser'

module Specinfra
  class HostInventory
    EXTRA_KEYS = %w(package user group service)

    def self.inventory_keys
      KEYS + EXTRA_KEYS
    end

    def each
      inventory_keys.each do |k|
        yield k, self[k]
      end
    end

    def each_key
      inventory_keys.each do |k|
        yield k
      end
    end

    def each_value
      inventory_keys.each do |k|
        yield self[k]
      end
    end
  end
end

Specinfra::HostInventory::EXTRA_KEYS.each do |k|
  require "koma/ext/specinfra/host_inventory/#{k}"
end
