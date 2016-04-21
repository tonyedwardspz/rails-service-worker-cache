Gem::Specification.new do |s|
  s.name        = 'service-worker-cache-rails'
  s.version     = '0.1.4'
  s.date        = '2016-04-18'
  s.summary     = 'Drop in solution for caching assets using a service worker.'
  s.description = 'Drop in solution for caching assets using a service worker.'
  s.authors     = ['Tony Edwards']
  s.email       = 'tony@plymouthsoftware.com'
  s.files       = Dir["{lib,public}/**/**/*"]
  s.homepage    = 'http://rubygems.org/gems/service-worker-cache-rails'
  s.license     = 'MIT'

  s.add_development_dependency "bundler", "~> 1.11"
  s.add_development_dependency "rake", "~> 10.0"
end
