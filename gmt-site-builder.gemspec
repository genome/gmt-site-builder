$:.push File.expand_path('../lib', __FILE__)
require 'gmt-site-builder/version'

Gem::Specification.new do |s|
  s.name          = 'gmt-site-builder'
  s.version       = GMTSiteBuilder::VERSION
  s.date          = '2014-05-01'
  s.summary       = "Build tool for generating the Genome Model Tools site"
  s.description   = "Build tool for generating the Genome Model Tools site"
  s.authors       = ["Adam Coffman", "Joshua McMichael"]
  s.email         = 'acoffman@genome.wustl.edu'
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.homepage      = 'https://github.com/genome/gmt-site-builder'
  s.license       = 'GPLv3'

  s.add_runtime_dependency('octokit', '~> 2.0')
  s.add_runtime_dependency('kramdown', '~> 1.4')
  s.add_runtime_dependency('jekyll', '~> 2.1.1')
end
