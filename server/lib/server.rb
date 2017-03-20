require 'api/v1'

class Server < Roda
  plugin :multi_run
  plugin :json

  run 'v1', Api::V1::Server

  route do |request|
    request.multi_run
  end
end
