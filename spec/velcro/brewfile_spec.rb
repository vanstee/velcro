require 'velcro/dependency'
require 'tempfile'

describe Velcro::Brewfile do
  subject { described_class.new }

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

  let(:postgresql) { Velcro::Dependency.new(name: 'postgresql') }
  let(:redis)      { Velcro::Dependency.new(name: 'redis', version: '2.4.16') }
  let(:parsed_dependencies) { [postgresql, redis] }

  before do
    Velcro::Dependency.any_instance.stub(:stable_version) { '9.1.4' }
  end

  describe '#parse' do
    it 'parses the Brewfile' do
      subject.parse_dependencies(content).should eql(parsed_dependencies)
    end
  end
end
