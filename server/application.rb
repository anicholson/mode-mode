require_relative './boot'

class Application < Dry::System::Container
  configure do |config|
    config.root = Pathname.new(File.dirname(__FILE__))

    config.auto_register = 'lib'
  end

  load_paths! 'lib'
end

Application.finalize!

Import = Application.injector
