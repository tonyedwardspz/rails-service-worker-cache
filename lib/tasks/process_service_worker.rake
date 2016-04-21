desc 'update the caching service worker file'
task process_service_worker_cache: :environment do
  puts 'Service Worker: Task Started'
  ServiceWorker.new
end

# This should trigger AFTER css /js has precompiiled
Rake::Task['assets:precompile'].enhance do
  Rake::Task['process_service_worker_cache'].invoke
end

class ServiceWorker
  attr_accessor :create

  def initialize
    puts "Service Worker: initialize"
    text_path = File.join(File.dirname(__FILE__), '../js/service_worker_client.js')
    @text = File.read(text_path)
    self.create
  end

  def create
    puts "Service Worker: create"
    new_file = File.open("#{Rails.root}/public/serviceWorker.js", 'w')

    @text.each_line do |line|
      if (line['FILES PLACEHOLDER'])
        new_file = self.insert_versioned_asset_strings(new_file)
      else
        new_file.puts line
      end
    end

    puts 'Service Worker: Created file'
    new_file.close
  end

  def insert_versioned_asset_strings(file)
    puts "Service Worker: insert versioned asset strings"
    RailsServiceWorkerCache.configuration.assets.each_with_index do |asset|
      puts "ServiceWorker: Processing assets/#{Rails.application.assets.find_asset(asset).digest_path}"
      file.puts "'  assets/#{Rails.application.assets.find_asset(asset).digest_path}'"

      # if this is not the last asset, append a ,
    end

    file
  end
end
