require 'ostruct'

class Velcro
  class Homebrew
    HOMEBREW_COMMAND = 'brew'

    def install_dependencies(dependencies)
      dependencies.each do |dependency|
        install(dependency)
      end
    end

    def install(dependency)
      command = "#{HOMEBREW_COMMAND} install #{dependency.name}"
      command << " -v #{dependency.version}" if dependency.version
      shellout(command)
    end

    def child_dependencies(dependency)
      deps(dependency).split.map do |child|
        child = OpenStruct.new(name: child)
        child.version = versions(child).split.first
        child
      end
    end

    def deps(dependency)
      command = "#{HOMEBREW_COMMAND} deps #{dependency.name}"
      shellout(command, true)
    end

    def versions(dependency)
      command = "#{HOMEBREW_COMMAND} versions --compact #{dependency.name}"
      shellout(command, true)
    end

    def shellout(command, quiet = false)
      output = `#{command}`
      puts output unless quiet
      output
    end
  end
end
