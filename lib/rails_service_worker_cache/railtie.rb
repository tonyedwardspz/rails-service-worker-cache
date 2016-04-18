require 'rails_service_worker_cache'
require 'rails'

module MyPlugin
  class Railtie < Rails::Railtie
    railtie_name :rails_service_worker_cache

    rake_tasks do
      load "tasks/process_service_worker.rake"
    end
  end
end
