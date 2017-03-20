require 'pry'
require 'rack'
require 'rack/test'
require 'rspec'
require 'rspec-hal'
require 'rom'
require 'rom-factory'

require_relative '../../application'

module Features
  module Global
    def app
      @app
    end
  end
end

World(Features::Global)
World(Rack::Test::Methods)
World(RSpec::Hal::Helpers)
World(RSpec::Hal::Matchers)

Factory = ROM::Factory.configure do |config|
  config.rom = Application['rom']
end

Factory.define(:mode, relation: :modes) do |f|
  f.name "factory-mode"
  f.url "http://example.org"
end
