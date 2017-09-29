# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "emblaze/version"

Gem::Specification.new do |spec|
  spec.name          = "emblaze"
  spec.version       = Emblaze::VERSION
  spec.authors       = ["Arda Karaduman"]
  spec.email         = ["akaraduman@gmail.com"]

  spec.summary       = %q{Simple rake task to deploy a static website to aws s3}
  spec.description   = %q{Simple rake task to deploy a static website to aws s3
  Minifies and gzips assets.
  Requires ENV variables (can be read from .env or travis if in CI) :
  AWS_REGION
  AWS_BUCKET_NAME
  AWS_SECRET_KEY
  AWS_ACCESS_KEY
  }
  spec.homepage      = "https://github.com/c0ze/emblaze"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 12.1.0"

  spec.add_runtime_dependency "aws-sdk", "~> 3.0.1"
  spec.add_runtime_dependency "rake", "~> 12.1.0"
  spec.add_runtime_dependency "dotenv", "~> 2.2.1"
  spec.add_runtime_dependency "reduce", "~> 0.3.0"
end
