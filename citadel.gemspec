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
	s.add_dependency('active_support', ['~> 3.0.0'])
	s.add_dependency("colored", ["~> 1.2"])  

end
