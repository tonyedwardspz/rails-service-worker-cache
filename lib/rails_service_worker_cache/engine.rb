require 'rails_service_worker_cache'
require 'rails'

module RailsServiceWorkerCache
  class Engine < Rails::Engine
    # railtie_name :rails_service_worker_cache

    initializer "static assets" do |app|
      app.middleware.use ::ActionDispatch::Static, "#{root}/public"
    end
  end
end
