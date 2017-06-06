# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'money_conv/version'

Gem::Specification.new do |spec|
  spec.name          = "money_conv"
  spec.version       = MoneyConv::VERSION
  spec.authors       = ["Macario"]
  spec.email         = ["mail@makarius.me"]

  spec.summary       = %q{Money currency conversion}
  spec.description   = %q{Money currency conversion}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = ["money_conv"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency "thor", "~> 0.19"
  spec.add_dependency "httparty", "~> 0.15"
  spec.add_dependency "damerau-levenshtein", "~> 1.2"
  spec.add_dependency "terminal-table", "~> 1.8"
end
