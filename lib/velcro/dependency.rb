require 'velcro'

unless ENV['TRAVIS']
  require 'formula'
end

class Velcro
  class Dependency
    DEPENDENCY_FORMAT = %r{^brew '(?<name>\S*)'(, '(?<version>\S*)')?$}

    attr_accessor :name, :version

    def initialize(options)
      @name = options.fetch(:name) { fail DependencyNameNotSpecified }
      @version = options.fetch(:version) { stable_version }
      @version_specified = options.key?(:version)
    end

    def install
      install!
    rescue DependencyNotFound
    rescue DependencyAlreadyInstalled
      nil
    end

    def install!
    end

    def children
    end

    def stable_version
      formula = Formula.factory(@name)
      formula.version.to_s
    end

    def installed?
    end

    def version_specified?
      @version_specified
    end

    def eql?(dependency)
      [:name, :version, :version_specified?].all? do |method_name|
        self.send(method_name) == dependency.send(method_name)
      end
    end

    def self.from_line(line)
      if line.match(/^brew/)
        name, version = line.match(DEPENDENCY_FORMAT).captures
        options = { name: name, version: version }
        options.delete_if { |_, v| v.nil? }
        new(options)
      end
    end
  end
end
