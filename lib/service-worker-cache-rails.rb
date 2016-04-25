require 'service-worker-cache-rails/rails'
require 'service-worker-cache-rails/rails/version'
require 'service-worker-cache-rails/rails/engine'
require 'service-worker-cache-rails/rails/railtie'

module ServiceWorkerCacheRails
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
