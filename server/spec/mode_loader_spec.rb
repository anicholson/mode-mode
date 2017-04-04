require 'spec_helper'
require 'mode_loader'


RSpec.describe 'ModeLoader' do
  subject { ModeLoader.new }

  let(:example_modes) do
    {
      modes: [
        { name: 'ruby', url: 'http::/ruby-mode.org' },
        { name: 'bash', url: 'http://bash-mode.org' }
      ]
    }
  end

  describe '#load_modes' do
    it 'loads the data file' do
      expect(YAML).to receive(:load_file).and_return({modes: []})

      subject.load_modes
    end

    it 'enters the information into the ModeRepository' do
      allow(YAML).to receive(:load_file).and_return(example_modes)

      modes_repo = Application['modes_repository']

      expect { subject.load_modes }.to change { modes_repo.count }.from(0).to(2)
    end
  end
end
