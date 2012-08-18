require 'velcro/version'
require 'velcro/homebrew'
require 'velcro/brewfile'
require 'velcro/lockfile'

class Velcro
  attr_accessor :homebrew

  def initialize
    self.homebrew = stub
    self.brewfile = stub
    self.lockfile = stub
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
