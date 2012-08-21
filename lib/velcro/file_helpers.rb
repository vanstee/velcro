class Velcro
  module FileHelpers
    def location
      ENV['VELCRO_BREWFILE'] || recursive_search
    end

    def recursive_search(directory = Dir.pwd)
      until directory == '/'
        return directory if File.exists?(brewfile_in(directory))
        directory = File.expand_path(File.join(directory, '..'))
      end
    end
  end
end
