module Api
  module V1
    class Server < Roda
      plugin :json
      plugin :caching

      route do |r|
        r.is '' do
          r.on do
            r.get do
              Application['api.v1.renderers.root'].render
            end
          end
        end

        r.on 'modes' do
          r.is do
            r.get do
              Application['api.v1.renderers.modes'].render
            end
          end
        end
      end
    end
  end
end
