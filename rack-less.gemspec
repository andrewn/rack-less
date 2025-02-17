# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rack/less/version"

Gem::Specification.new do |s|
  s.name        = "rack-less"
  s.version     = Rack::Less::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Kelly Redding"]
  s.email       = ["kelly@kelredd.com"]
  s.homepage    = "http://github.com/kelredd/rack-less"
  s.summary     = %q{LESS CSS preprocessing for Rack apps.}
  s.description = %q{LESS CSS preprocessing for Rack apps.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency("bundler", ["~> 1.0"])
  s.add_development_dependency("assert", ["~>0.3.0"])

  s.add_development_dependency("sinatra", ["~> 1.2"])
  s.add_development_dependency("rack-test", ["~> 0.6.0"])
  s.add_development_dependency("webrat", ["~> 0.7.0"])
  s.add_development_dependency("yui-compressor", ["~> 0.9.0"])

  s.add_dependency("rack", ["~> 1.0"])
  s.add_dependency("less", ["~> 2.0"])
end
