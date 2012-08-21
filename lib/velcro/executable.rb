require 'velcro'
require 'thor'

class Velcro
  class Executable < Thor
    default_task :install

    desc 'install', 'Install dependencies defined in the Brewfile'
    def install
      velcro.install
    end

    no_tasks do
      def velcro
        Velcro.new
      end
    end
  end
end
