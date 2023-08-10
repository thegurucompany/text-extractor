# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'text_extractor/version'

Gem::Specification.new do |spec|
  spec.name          = "text-extractor"
  spec.version       = TextExtractor::VERSION
  spec.authors       = ['Jens Krämer', 'Planio GmbH', 'OpenProject GmbH']
  spec.email         = ['info@openproject.com']

  spec.summary       = 'Extract plain text from most common office documents.'
  spec.description   = "Extract text from common office files. Based on the file's content type a command line tool is selected to do the job."
  spec.homepage      = 'https://github.com/planio-gmbh/text-extractor'
  
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'rubyzip', '~> 2.3.2'
  spec.add_dependency 'nokogiri', '~> 1.15.3'
  spec.add_dependency 'activesupport', '~> 7.0.6'

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
