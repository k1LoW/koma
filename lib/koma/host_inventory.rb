module Koma
  class HostInventory
    EXTRA_KEYS = %w(package group service)
    DISABLED_KEYS = %w(ec2)

    def self.inventory_keys
      Specinfra::HostInventory::KEYS + EXTRA_KEYS - DISABLED_KEYS
    end

    def self.all_inventory_keys
      Specinfra::HostInventory::KEYS + EXTRA_KEYS
    end

    def self.disabled_keys
      DISABLED_KEYS
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

Koma::HostInventory::EXTRA_KEYS.each do |k|
  require "koma/ext/specinfra/host_inventory/#{k}"
end
