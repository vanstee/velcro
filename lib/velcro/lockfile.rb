require 'velcro/file_helpers'

class Velcro
  class Lockfile
    include FileHelpers

    def generate(dependencies)
      write_to_lockfile(
        [
          'FORMULA',
          indent(generate_formula(dependencies)),
          '',
          'DEPENDENCIES',
          indent(generate_dependencies(dependencies)),
          ''
        ].flatten.join("\n")
      )
    end

    def generate_formula(dependencies)
      dependencies.map do |dependency|
        [
          "#{dependency.name} (#{dependency.version})",
          indent(generate_child_dependencies(dependency))
        ]
      end.flatten
    end

    def generate_child_dependencies(dependency)
      dependency.children.map do |child|
        "#{child.name} (#{child.version})"
      end
    end

    def generate_dependencies(dependencies)
      dependencies.map do |dependency|
        line = "#{dependency.name}"
        line << " (#{dependency.version})" if dependency.version_specified?
        line
      end
    end

    def indent(lines)
      Array(lines).map do |line|
        "  #{line}"
      end
    end

    def write_to_lockfile(content)
      File.open(lockfile_in(Dir.pwd), 'w+') do |lockfile|
        lockfile.write(content)
      end
    end

    def lockfile_in(directory)
      File.join(directory, 'Brewfile.lock')
    end
  end
end
