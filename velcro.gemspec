# encoding: utf-8
require File.expand_path('../lib/velcro/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'velcro'
  gem.version       = Velcro::VERSION
  gem.authors       = ['vanstee']
  gem.email         = ['vanstee@highgroove.com']
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ''

  gem.files         = `git ls-files`.split
  gem.executables   = `git ls-files -- bin/*`.split.map { |f| File.basename(f) }
  gem.test_files    = `git ls-files -- spec/*`.split
  gem.require_paths = ['lib']

  gem.add_development_dependency 'rspec', '~> 2.11.0'
  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'rake'
end
