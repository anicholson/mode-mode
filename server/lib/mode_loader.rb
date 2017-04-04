require 'yaml'

class ModeLoader
  def initialize
    @data_file_name = 'modes.yml'
  end

  def load_modes
    mode_data = YAML.load_file(data_file_name)[:modes]
    Application['modes_repository'].create(mode_data)
  end

  private

  attr_reader :data_file_name
end
