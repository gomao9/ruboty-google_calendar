# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruboty/google_calendar/version'

Gem::Specification.new do |spec|
  spec.name          = "ruboty-google_calendar"
  spec.version       = Ruboty::GoogleCalendar::VERSION
  spec.authors       = ["gomao9"]
  spec.email         = ["gomaoq@gmail.com"]

  spec.summary       = "ruboty plugin for Google Calendar"
  spec.homepage      = "https://github.com/gomao9/ruboty-google_calendar"
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

  spec.add_runtime_dependency "google-api-client", '~>0.8.6'
  spec.add_runtime_dependency "ruboty"
  spec.add_runtime_dependency "activesupport"
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
end
