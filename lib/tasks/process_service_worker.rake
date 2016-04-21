desc 'update the caching service worker file'
task process_service_worker_cache: :environment do
  puts 'Service Worker: Task Started'
  ServiceWorker.new
end

# Trigger the task to run when assets are precompiiled
Rake::Task['assets:precompile'].enhance do
  Rake::Task['process_service_worker_cache'].invoke
end

# Encapsulate creating the service worker file
class ServiceWorker
  attr_accessor :create

  def initialize
    self.log_message('Initalizing object')
    text_path = File.join(File.dirname(__FILE__), '../js/service_worker_client.js')
    @text = File.read(text_path)
    self.create
  end

  def create
    log_message('Creating file')

    File.open("#{Rails.root}/public/serviceWorker.js", 'w') do | file |
      file = self.insert_debug_variable(file)
      file = self.insert_cache_name(file)
      file = self.insert_versioned_asset_strings(file)
    end

    self.log_message('Finished creating file')
  end

  def insert_versioned_asset_strings(file)
    file.puts 'var urlsToCache = ['
    RailsServiceWorkerCache.configuration.assets.each_with_index do | asset, i |
      self.log_message("Processing assets/#{Rails.application.assets.find_asset(asset).digest_path}")
      file.puts "'  assets/#{Rails.application.assets.find_asset(asset).digest_path}'#{',' if (i+1) < RailsServiceWorkerCache.configuration.assets.length}"
    end
    file.puts '];'
    file
  end

  def insert_debug_variable(file)
    file.puts 'var RSWC_DEBUG = true;' if RailsServiceWorkerCache.configuration.debug
    file
  end

  def insert_cache_name(file)
    file.puts "var CACHE_NAME = '#{RailsServiceWorkerCache.configuration.cache_name}';"
    file
  end

  def log_message(message)
    if RailsServiceWorkerCache.configuration.debug == true
      puts "Service Worker Cache: #{message}"
    end
  end
end
