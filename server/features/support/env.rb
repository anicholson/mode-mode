require 'pry'
require 'rack'
require 'rack/test'
require 'rspec'
require 'rspec-hal'
require 'rspec/expectations'
require 'rspec/mocks'
require 'rom'
require 'rom-factory'
require 'cucumber/rspec/doubles'

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
World(RSpec::Matchers)
World(RSpec::Mocks::Matchers)

Factory = ROM::Factory.configure do |config|
  config.rom = Application['rom']
end

Factory.define(:mode, relation: :modes) do |f|
  f.name "factory-mode"
  f.url "http://example.org"
end

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end


Around do |scenario, block|
  rom = Application['rom']
  rom.gateways[:default].transaction(rollback: :always)  { block.call }
end
