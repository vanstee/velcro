require 'velcro/dependency'
require 'tempfile'

describe Velcro::Lockfile do
  subject { described_class.new }

  let(:postgresql) { Velcro::Dependency.new(name: 'postgresql') }
  let(:redis)      { Velcro::Dependency.new(name: 'redis', version: '2.4.16') }
  let(:ossp_uuid)  { Velcro::Dependency.new(name: 'ossp-uuid', version: '1.6.2') }
  let(:readline)   { Velcro::Dependency.new(name: 'readline', version: '6.2.4') }

  let(:dependencies) { [postgresql, redis] }
  let(:children)     { [ossp_uuid, readline] }

  let(:lockfile) { Tempfile.new('lockfile') }

  before do
    Velcro::Dependency.any_instance.stub(:stable_version) { '9.1.4' }

    subject.stub(:lockfile_in) { lockfile }

    postgresql.stub(:children) { children }
    redis.stub(:children)      { [] }
  end

  describe '#generate' do
    it 'creates a Brewfile.lock for the installed dependencies' do
      subject.generate(dependencies)
      File.read(lockfile).should == <<-END.gsub(/^ {8}/, '')
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
