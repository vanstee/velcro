require 'velcro/dependency'

describe Velcro::Dependency do
  let(:redis) { described_class.new(name: 'redis') }

  before do
    Velcro::Dependency.any_instance.stub(:stable_version) { '2.4.16' }
  end

  context '#initialize' do
    it 'requires a name key' do
      -> { described_class.new(version: '2.4.16') }.should
        raise_error(Velcro::DependencyNameNotSpecified)
    end

    it 'uses the most stable version if not specified' do
      redis.version.should == '2.4.16'
    end

    it 'remembers if the version was specified' do
      redis.should_not be_version_specified
    end
  end
end
