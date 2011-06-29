# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "autocuke/version"

Gem::Specification.new do |s|
  s.name        = "autocuke"
  s.version     = Autocuke::VERSION
  s.authors     = ["Spencer Steffen"]
  s.email       = ["spencer@citrusme.com"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "autocuke"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  # Runtime
  s.add_dependency('eventmachine', '>= 0.12.10')
  
  # Development
  s.add_development_dependency('dummier',          '>= 0.2.0')
  s.add_development_dependency('shoulda',          '>= 2.11.3')
  s.add_development_dependency('cucumber-rails',   '>= 0.4.1')
	s.add_development_dependency('factory_girl',     '>= 2.0.0.beta2')
	s.add_development_dependency('database_cleaner', '>= 0.6.7')
	s.add_development_dependency('sqlite3',          '>= 1.3.3')

end
