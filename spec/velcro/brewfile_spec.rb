require 'velcro/brewfile'
require 'tempfile'

describe Velcro::Brewfile do
  let(:content) {
    <<-END.gsub(/^\s{6}/, '')
      brew 'postgresql'
      brew 'redis', '2.4.16'
    END
  }

  let(:file) {
    Tempfile.new('brewfile') do |f|
      f.write(content)
    end
  }

  let(:parsed_content) {
    [
      OpenStruct.new(name: 'postgresql', version: nil),
      OpenStruct.new(name: 'redis',      version: '2.4.16')
    ]
  }

  subject { described_class.new }

  describe '#parse' do
    it 'parses the Brewfile' do
      subject.parse_dependencies(content).should == parsed_content
    end
  end
end
