require 'ostruct'

class Velcro
  class Brewfile
    DEPENDENCY_FORMAT = %r{^brew '(?<name>\S*)'(, '(?<version>\S*)')?$}

    attr_accessor :path, :dependencies

    def initialize(path)
      self.path = path
      self.dependencies = parse_dependencies(content)
    end

    def parse_dependencies(content)
      content.split("\n").map do |line|
        parse_line(line)
      end.flatten.compact
    end

    def parse_line(line)
      if line.match(/^brew/)
        line.scan(DEPENDENCY_FORMAT).map do |name, version|
          OpenStruct.new(name: name, version: version)
        end
      end
    end

    def content
      File.read(self.path)
    end
  end
end
