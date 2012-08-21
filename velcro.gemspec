# encoding: utf-8
require File.expand_path('../lib/velcro/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'velcro'
  gem.version       = Velcro::VERSION
  gem.authors       = ['vanstee', 'tomelm']
  gem.email         = ['vanstee@highgroove.com']
  gem.description   = %q{Manage your dependencies with homebrew like you manage your gems with bundler}
  gem.summary       = %q{Manage your dependencies with homebrew like you manage your gems with bundler}
  gem.homepage      = 'http://github.com/vanstee/velcro'

  gem.files         = `git ls-files`.split
  gem.executables   = `git ls-files -- bin/*`.split.map { |f| File.basename(f) }
  gem.test_files    = `git ls-files -- spec/*`.split
  gem.require_paths = ['lib']

  gem.add_dependency 'thor' , '~> 0.16.0'

  gem.add_development_dependency 'rspec', '~> 2.11.0'
  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'rake'
end
