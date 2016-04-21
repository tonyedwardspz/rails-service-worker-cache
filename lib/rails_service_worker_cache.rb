require 'rails_service_worker_cache/rails'
require 'rails_service_worker_cache/rails/version'
require 'rails_service_worker_cache/rails/engine' if defined?(Rails)
require 'rails_service_worker_cache/rails/railtie' if defined?(Rails)

module RailsServiceWorkerCache
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :assets
    attr_accessor :debug
    attr_accessor :cache_name

    def initialize
      @assets = []
      @debug = false
      @cache_name = 'my-app-cache'
    end
  end
end
