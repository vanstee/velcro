require 'velcro'

describe Velcro do
  subject { described_class.new(stub) }

  context '#install' do
    let(:homebrew) { stub(install_dependencies: nil) }
    let(:dependencies) { stub }
    let(:brewfile) { stub(dependencies: dependencies) }
    let(:lockfile) { stub(generate: nil) }

    before do
      subject.stub(:homebrew) { homebrew }
      subject.stub(:brewfile) { brewfile }
      subject.stub(:lockfile) { lockfile }
    end

    it 'installs the necessary dependencies' do
      homebrew.should_receive(:install_dependencies).with(dependencies)

      subject.install
    end

    it 'generates a Brewfile.lock if not yet created' do
      lockfile.should_receive(:generate).with(dependencies)

      subject.install
    end
  end
end
