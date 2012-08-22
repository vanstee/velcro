require 'velcro/errors'
require 'velcro/file_helpers'

class Velcro
  class Brewfile
    include FileHelpers

    def dependencies
      parse_dependencies(content)
    end

    def parse_dependencies(content)
      content.split("\n").map do |line|
        Dependency.from_line(line)
      end.flatten.compact
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
