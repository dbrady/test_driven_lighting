require_relative 'lib/test_driven_lighting/version.rb'
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)


Gem::Specification.new do |s|
  s.name          = 'test_driven_lighting'
  s.version       = TestDrivenLighting::VERSION
  s.license       = 'MIT'
  s.summary       = 'test driven lighting for hue bulbs'
  s.description   = 'provides sender and receiver classes for entities that want to change the bulbs, and the entities that have bulbs to change'
  s.authors       = ['Ashton Freidenberger','Brian Lees','Dave Brady','Daniel DeStefano']
  s.email         = 'afreidenberger@covermymeds.com'
  s.homepage      = 'http://www.covermymeds.com'
  s.require_paths = ["lib"]
  s.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  s.bindir        = "bin"
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }

  s.add_dependency 'bunny', '~> 2.7'
  s.add_dependency 'faraday', '~> 0.12.2'
  s.add_dependency 'json', '~> 2.1'

  s.add_development_dependency 'byebug', '~> 9.0'
  s.add_development_dependency 'pry', '~> 0.11.3'
  s.add_development_dependency 'rspec', '~> 3.5'
end
