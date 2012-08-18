require 'velcro/homebrew'
require 'ostruct'

describe Velcro::Homebrew do
  subject { described_class.new }

  context 'installing dependencies' do
    let(:postgresql) { OpenStruct.new(name: 'postgresql') }
    let(:redis)      { OpenStruct.new(name: 'redis') }
    let(:dependencies) { [postgresql, redis] }

    describe '#install_dependencies' do
      it 'installs the dependencies' do
        subject.should_receive(:install).with(postgresql)
        subject.should_receive(:install).with(redis)

        subject.install_dependencies(dependencies)
      end
    end

    describe '#install' do
      it 'installs a dependecy' do
        subject.should_receive(:shellout).with('brew install redis')

        subject.install(redis)
      end

      it 'installs the correct version of a dependency' do
        redis.version = '2.4.16'

        subject.should_receive(:shellout).with('brew install redis -v 2.4.16')

        subject.install(redis)
      end
    end
  end
end
