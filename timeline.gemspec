$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "timeline/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "models_timeline"
  s.version     = Timeline::VERSION
  s.authors     = ["Angelo Capilleri"]
  s.email       = ["capilleri@yahoo.com"]
  s.homepage    = "https://github.com/acapilleri/timeline"
  s.summary     = %q{Timeline of you model objects}
  s.description = %q{Allow to create a timeline of your crud operations }

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.9"
  # s.add_dependency "jquery-rails"
  s.add_development_dependency "debugger"
  s.add_development_dependency "sqlite3"
end
