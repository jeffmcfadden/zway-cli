# coding: utf-8 #


lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zway/cli/version'

Gem::Specification.new do |spec|
  spec.name          = "zway-cli"
  spec.version       = Zway::Cli::VERSION
  spec.authors       = ["jeffmcfadden"]
  spec.email         = ["jeff@forgeapps.com"]

  spec.summary       = %q{Control your ZWay Server from the command line.}
  spec.description   = %q{Control your ZWay Server from the command line.}
  spec.homepage      = "https://github.com/jeffmcfadden/zway-cli"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
