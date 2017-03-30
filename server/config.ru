require_relative './application'

require 'server'

require 'rack/cors'

use Rack::Cors do
  allow do
    origins '*'
    resource '/v1/*', headers: :any, methods: :get
  end
end

run Server.freeze.app
