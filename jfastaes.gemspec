# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "jfastaes/version"

Gem::Specification.new do |s|
  s.name        = "jfastaes"
  s.version     = JFastAES::VERSION
  s.authors     = ["Tobias Schlottke"]
  s.email       = ["tobias.schlottke@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "jfast_aes"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
  s.add_development_dependency 'shoulda-context'
  s.add_development_dependency 'buildr', '1.4.6'
  s.add_development_dependency 'ci_reporter'
  
  # necessary instead of Mini:Unit as Mini:Unit cannot produce Jenkins-compatible test results
  s.add_development_dependency 'test-unit'
end
