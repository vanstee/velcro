require 'velcro/version'
require 'velcro/homebrew'

class Velcro
  attr_accessor :homebrew, :brewfile, :lockfile

  def initialize(path)
    self.homebrew = Homebrew.new
    self.brewfile = Brewfile.new(path)
    self.lockfile = nil
  end

  def install
    install_dependencies
    generate_lockfile
  end

  def install_dependencies
    homebrew.install_dependencies(brewfile.dependencies)
  end

  def generate_lockfile
    lockfile.generate(brewfile.dependencies)
  end
end
