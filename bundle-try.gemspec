# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "bundle-try"
  spec.version       = '1.0.0'
  spec.authors       = ["Gert Goet"]
  spec.email         = ["gert@thinkcreate.nl"]

  spec.summary       = %q{Start a REPL with the gems you want to try}
  spec.description   = %q{Start a REPL with the gems you want to try}
  spec.homepage      = "https://github.com/eval/bundle-try"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
