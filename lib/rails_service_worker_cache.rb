module RailsServiceWorkerCache
  require 'rails_service_worker_cache/railtie' if defined?(Rails)
  require 'rails_service_worker_cache/engine' if defined?(Rails)
end
