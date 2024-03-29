require_relative 'lib/stowe/version'

Gem::Specification.new do |spec|
  spec.name          = "stowe"
  spec.version       = Stowe::VERSION
  spec.authors       = ["Weliton Jose"]
  spec.email         = ["professorweltonjose@gmail.com"]

  spec.summary       = %"Generation Stowe"
  spec.description   = "Generation Stowe"
  spec.homepage      = "https://stowe.com.br"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]


  ##dependencie
  spec.add_dependency "sidekiq"
  spec.add_dependency "dotenv-rails"
  ### gem 'devise', git: 'https://github.com/heartcombo/devise', branch: 'main'
end
