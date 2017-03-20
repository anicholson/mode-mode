module Api
  module V1
    module Renderers
      class Modes
        include Halogen

        property(:count) { Application['modes_repository'].count }
        property(:modes) { Application['modes_repository'].all.map(&:to_h) }

        link(:self) { '/modes?format=json'  }
      end
    end
  end
end
