# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "factory_girl_mongo_syntax/version"

Gem::Specification.new do |s|
  s.name        = "factory_girl_mongo_syntax"
  s.version     = FactoryGirlMongoSyntax::VERSION
  s.authors     = ["Adnan Ali"]
  s.email       = ["adnan.ali@gmail.com"]
  s.homepage    = ""
  s.summary     = "Adds factory girl alternate (Machinist) syntax to MongoMapper"
  s.description = s.summary

  s.rubyforge_project = "factory_girl_mongo_syntax"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_development_dependency "mongo"
  s.add_development_dependency "mongo_mapper"
  s.add_development_dependency "rake"
  s.add_runtime_dependency "factory_girl"
end
