require 'velcro/errors'
require 'velcro/file_helpers'
require 'ostruct'

class Velcro
  class Brewfile
    include FileHelpers

    DEPENDENCY_FORMAT = %r{^brew '(?<name>\S*)'(, '(?<version>\S*)')?$}

    def dependencies
      parse_dependencies(content)
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
      if location
        File.read(brewfile_in(location))
      else
        fail BrewfileNotFound, 'Could not locate Brewfile'
      end
    end

    def brewfile_in(directory)
      File.join(directory, 'Brewfile')
    end
  end
end
