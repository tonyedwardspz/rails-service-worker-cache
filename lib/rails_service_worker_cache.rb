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

    def initialize
      @assets = []
      @debug = false
    end
  end
end
