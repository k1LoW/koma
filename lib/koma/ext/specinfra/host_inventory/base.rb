module Specinfra
  class HostInventory
    class Base
      private

      def create_parser_class(resource_type)
        os_info = backend.os
        family = os_info[:family]
        version = os_info[:release] ? "V#{os_info[:release].to_i}" : nil
        common_class = Specinfra::HostInventory::Parser
        base_class = common_class.const_get('Base')
        os_class = family.nil? ? base_class : common_class.const_get(family.capitalize)

        if family && version
          begin
            version_class = os_class.const_get(version)
          rescue
            version_class = os_class.const_get('Base')
          end
        elsif family.nil?
          version_class = os_class
        elsif family != 'base' && version.nil?
          version_class = os_class.const_get('Base')
        end

        begin
          parser_class = version_class.const_get(resource_type.to_camel_case)
        rescue
        end

        parser_class.create(backend)
      end
    end
  end
end
