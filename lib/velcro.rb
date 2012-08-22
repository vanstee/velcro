require 'velcro/brewfile'
require 'velcro/errors'
require 'velcro/lockfile'
require 'velcro/version'

$:.unshift('/usr/local/Library/Homebrew')

unless ENV['TRAVIS']
  begin
    require 'global'
  rescue LoadError
    fail Velcro::HomebrewNotFound, 'Please install homebrew before using velcro: http://mxcl.github.com/homebrew'
  end
end

class Velcro
  attr_accessor :brewfile, :lockfile

  def initialize
    self.brewfile = Brewfile.new
    self.lockfile = Lockfile.new
  end

  def install
    install_dependencies
    generate_lockfile
  end

  def install_dependencies
    brewfile.dependencies.each(&:install!)
  end

  def generate_lockfile
    lockfile.generate(brewfile.dependencies)
  end
end
