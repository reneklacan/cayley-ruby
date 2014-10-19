$:.push File.expand_path("../lib", __FILE__)

require 'cayley/version'

Gem::Specification.new do |s|
  s.name        = 'cayley'
  s.version     = Cayley::VERSION
  s.date        = Time.now.strftime('%Y-%m-%d')
  s.summary     = "Ruby library for working with Google's Cayley graph database"
  s.description = "Ruby library for working with Google's Cayley graph database"
  s.authors     = ['Rene Klacan']
  s.email       = 'rene@klacan.sk'
  s.files       = Dir["{lib}/**/*", "LICENSE", "README.md"]
  s.executables = []
  s.homepage    = 'https://github.com/reneklacan/cayley-ruby'
  s.license     = 'Beerware'

  s.required_ruby_version = '>= 1.9'

  s.add_dependency 'json', '~> 1.8.1'
  s.add_dependency 'curb', '~> 0.8.5'
  s.add_dependency 'hashie', '~> 3.2.0'
  s.add_dependency 'activesupport', '~> 4.1.4'

  s.add_development_dependency 'rspec', '~> 3.1'
  s.add_development_dependency 'rspec-mocks', '~> 3.1'
end
