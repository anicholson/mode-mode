require 'digest'

module Api
  module V1
    module Renderers
      class Root
        include Halogen

        link(:self) { '/?format=json' }
        link(:modes) { '/modes?format=json' }

        class << self
          def sha1
            @sha1 ||= Digest::SHA1.hexdigest(new.render.to_json)
          end
        end
      end
    end
  end
end
