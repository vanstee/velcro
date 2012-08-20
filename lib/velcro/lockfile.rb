require 'velcro/homebrew'

class Velcro
  class Lockfile
    attr_accessor :path, :homebrew

    def initialize(path)
      self.path = path
      self.homebrew = Homebrew.new
    end

    def generate(dependencies)
      [
        'FORMULA',
        indent(generate_formula(dependencies)),
        '',
        'DEPENDENCIES',
        indent(generate_dependencies(dependencies))
      ].flatten.join("\n")
    end

    def generate_formula(dependencies)
      dependencies.map do |dependency|
        [
          "#{dependency.name} (#{specified_or_most_recent_version(dependency)})",
          indent(generate_child_dependencies(dependency))
        ]
      end.flatten
    end

    def generate_child_dependencies(dependency)
      self.homebrew.child_dependencies(dependency).map do |child|
        "#{child.name} (#{child.version})"
      end
    end

    def generate_dependencies(dependencies)
      dependencies.map do |dependency|
        line = "#{dependency.name}"
        line << " (#{dependency.version})" if dependency.version
        line
      end
    end

    def specified_or_most_recent_version(dependency)
      dependency.version || self.homebrew.versions(dependency).split.first
    end

    def indent(lines)
      Array(lines).map do |line|
        "  #{line}"
      end
    end
  end
end
