require 'velcro/version'
require 'velcro/homebrew'
require 'velcro/brewfile'
require 'velcro/lockfile'

class Velcro
  attr_accessor :homebrew, :brewfile, :lockfile

  def initialize
    self.homebrew = Homebrew.new
    self.brewfile = Brewfile.new
    self.lockfile = Lockfile.new
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
