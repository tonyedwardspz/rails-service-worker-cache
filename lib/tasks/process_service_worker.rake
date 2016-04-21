desc 'update the caching service worker file'
task process_service_worker_cache: :environment do
  puts 'Service Worker: Task Started'
  ServiceWorker.new
end

# Trigger the task to run when assets are precompiiled
Rake::Task['assets:precompile'].enhance do
  Rake::Task['process_service_worker_cache'].invoke
end




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
    new_file = File.open("#{Rails.root}/public/serviceWorker.js", 'w')

    @text.each_line do |line|
      if (line['FILES PLACEHOLDER'])
        new_file = self.insert_versioned_asset_strings(new_file)
      else
        new_file.puts line
      end
    end

    self.log_message('Finished creating file')
    new_file.close
  end

  def insert_versioned_asset_strings(file)
    RailsServiceWorkerCache.configuration.assets.each_with_index do |asset|
      self.log_message('Processing assets/#{Rails.application.assets.find_asset(asset).digest_path}"')
      file.puts "'  assets/#{Rails.application.assets.find_asset(asset).digest_path}'"

      # if this is not the last asset, append a ,
    end

    file
  end

  def log_message(message)
    puts "logging"
    if RailsServiceWorkerCache.configuration.debug == true
      Rails.logger.info "Service Worker Cache: #{message}"
    end
  end
end
