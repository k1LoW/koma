module Koma
  module Backend
    class Exec < Base
      def gather
        set :backend, :exec
        result = out(options[:key])
      end
    end
  end
end
