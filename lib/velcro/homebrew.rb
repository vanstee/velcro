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

    def shellout(command)
      system(command)
    end
  end
end
