# encoding: utf-8
require 'active_support/core_ext/string'


module Citadel; end

File.tap do |f|
	Dir[f.expand_path(f.join(f.dirname(__FILE__),'lib', 'citadel', '**/*.rb'))].each do |file|

		Citadel.autoload File.basename(file, '.rb').camelize, file
	end
end

