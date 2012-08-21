require 'velcro/file_helpers'

describe Velcro::FileHelpers do
  subject { Class.new.extend(described_class) }

  describe '#location' do
    let(:velcro_brewfile) { stub }

    it 'returns the brewfile location specified in the environment variable' do
      ENV.stub(:[]).with('VELCRO_BREWFILE') { velcro_brewfile }
      subject.location.should == velcro_brewfile
    end

    it 'recursively searches for the Brewfile if not specified' do
      subject.stub(:recursive_search) { nil }
      subject.should_receive(:recursive_search)

      subject.location
    end
  end
end
