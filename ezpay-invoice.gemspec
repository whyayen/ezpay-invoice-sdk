lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ezpay-invoice/version'

Gem::Specification.new do |spec|
  spec.name          = "ezpay-invoice"
  spec.version       = EzpayInvoice::VERSION
  spec.authors       = ["Whyayen"]
  spec.email         = ["c75a90@gmail.com"]

  spec.add_dependency 'rest-client', '~> 2.1.0'
  spec.add_dependency 'hashie', '~> 5.0.0'
  spec.add_dependency 'addressable', '~> 2.8.0'
  spec.add_dependency 'activesupport', ['>= 5.0.0', '<= 7.0.1']

  spec.summary       = %q{The unofficial Ezpay invoice ruby SDK.}
  spec.description   = %q{The package would be able to issue invoice, invalid invoice on Ezpay}
  spec.homepage      = "https://github.com/whyayen/ezpay-invoice-sdk"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/whyayen/ezpay-invoice-sdk"
  spec.metadata["changelog_uri"] = "https://github.com/whyayen/ezpay-invoice-sdk"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
