include Specinfra::Helper::Set

class Koma::Backend::Base
  attr_reader :host, :options, :inventory_keys

  def initialize(host, options)
    @host = host
    @options = options
    @inventory_keys = Koma::HostInventory.inventory_keys
  end

  def out(key = nil)
    out = {}
    keys = if key.nil?
             inventory_keys
           else
             key.split(',')
           end
    keys.each do |k|
      raise Koma::NotImplementedKeyError unless Koma::HostInventory.all_inventory_keys.include?(k)
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
