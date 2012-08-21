require 'velcro/lockfile'

describe Velcro::Lockfile do
  subject { described_class.new }

  let(:postgresql) { OpenStruct.new(name: 'postgresql', version: nil) }
  let(:redis)      { OpenStruct.new(name: 'redis', version: '2.4.16') }
  let(:ossp_uuid)  { OpenStruct.new(name: 'ossp-uuid', version: '1.6.2') }
  let(:readline)   { OpenStruct.new(name: 'readline', version: '6.2.4') }

  let(:dependencies) { [postgresql, redis] }
  let(:child_dependencies) { [ossp_uuid, readline] }

  before do
    subject.homebrew.stub(:child_dependencies).with(postgresql) { child_dependencies }
    subject.homebrew.stub(:child_dependencies).with(redis) { [] }
    subject.homebrew.stub(:versions).with(postgresql) { '9.1.4' }
  end

  describe '#generate' do
    it 'creates a Brewfile.lock for the installed dependencies' do
      subject.generate(dependencies).should == <<-END.gsub(/^ {8}/, '').rstrip
        FORMULA
          postgresql (9.1.4)
            ossp-uuid (1.6.2)
            readline (6.2.4)
          redis (2.4.16)

        DEPENDENCIES
          postgresql
          redis (2.4.16)
      END
    end
  end
end
