
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "alipay_mini/version"

Gem::Specification.new do |spec|
  spec.name          = "alipay_mini"
  spec.version       = AlipayMini::VERSION
  spec.authors       = ["renyijiu"]
  spec.email         = ["lanyuejin1108@gmail.com"]

  spec.summary       = %q{An unofficial simple alipay mini program gem}
  spec.description   = %q{An unofficial simple alipay mini program gem}
  spec.homepage      = "https://github.com/renyijiu/alipay_mini"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
