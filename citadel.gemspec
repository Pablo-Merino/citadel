$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
name = "citadel"
require "#{name}/version"

Gem::Specification.new name, Citadel::VERSION do |s|
	s.summary = "A CI server"
	s.authors = ["Pablo Merino"]
	s.email = "pablo@wearemocha.com"
	s.homepage = "http://github.com/pablo-merino/#{name}"
	s.files = `git ls-files`.split("\n")
	s.license = "MIT"
	s.executables   = `ls bin/*`.split("\n").map{ |f| File.basename(f) }
	s.add_dependency('active_support', ['~> 3.0.0'])
	s.add_dependency("colored", ["~> 1.2"])  
  s.add_dependency("colored", ["~> 1.2"])  
  s.add_dependency("sinatra", ["~> 1.4.2"])  
  s.add_dependency("sequel", ["~> 3.47.0"])  
  s.add_dependency("i18n", ["~> 0.6.5"])  
  s.add_dependency("sqlite3", ["~> 1.3.8"])  
end
