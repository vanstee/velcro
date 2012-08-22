require 'velcro'

describe Velcro do
  subject { described_class.new }

  context '#install' do
    let(:dependency) { stub(install!: nil) }
    let(:dependencies) { [dependency] }
    let(:brewfile) { stub(dependencies: dependencies) }
    let(:lockfile) { stub(generate: nil) }

    before do
      subject.stub(:brewfile) { brewfile }
      subject.stub(:lockfile) { lockfile }
    end

    it 'installs the necessary dependencies' do
      dependencies.each do |dependency|
        dependency.should_receive(:install!)
      end

      subject.install
    end

    it 'generates a Brewfile.lock if not yet created' do
      lockfile.should_receive(:generate).with(dependencies)

      subject.install
    end
  end
end
