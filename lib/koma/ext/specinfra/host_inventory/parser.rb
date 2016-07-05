class Specinfra::HostInventory::Parser;end;

require 'koma/ext/specinfra/host_inventory/parser/base'
require 'koma/ext/specinfra/host_inventory/parser/base/package'
require 'koma/ext/specinfra/host_inventory/parser/base/service'

require 'koma/ext/specinfra/host_inventory/parser/linux'
require 'koma/ext/specinfra/host_inventory/parser/linux/base'
require 'koma/ext/specinfra/host_inventory/parser/linux/base/package'
require 'koma/ext/specinfra/host_inventory/parser/linux/base/service'

require 'koma/ext/specinfra/host_inventory/parser/redhat'
require 'koma/ext/specinfra/host_inventory/parser/redhat/base'
require 'koma/ext/specinfra/host_inventory/parser/redhat/base/package'
require 'koma/ext/specinfra/host_inventory/parser/redhat/base/service'
require 'koma/ext/specinfra/host_inventory/parser/redhat/v7'
require 'koma/ext/specinfra/host_inventory/parser/redhat/v7/service'
