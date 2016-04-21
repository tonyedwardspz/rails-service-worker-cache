desc 'update the caching service worker file'
task process_service_worker_cache: :environment do

  puts 'Processing Service Worker'
  puts RailsServiceWorkerCache.configuration.assets

  ServiceWorker.create_file
end

class ServiceWorker
  def initialize
    @text_path = File.join(File.dirname(__FILE__), '../js/service_worker_client.js')
    @text = File.read(text_path)
  end

  def create_file
    new_file = File.open("#{Rails.root}/public/serviceWorker.js", 'w')

    @text.each_line do |line|
      if (line['FILES PLACEHOLDER'])
        new_file = insert_versioned_asset_strings(new_file)
      else
        new_file.puts line
      end
    end
    new_file.close
  end

  def insert_versioned_asset_strings(file)
    RailsServiceWorkerCache.configuration.assets.each_with_index do |asset|
      file.puts "  assets/#{Rails.application.assets.find_asset(asset).digest_path}"

      # if this is not the last asset, append a ,
    end

    file
  end
end

# This should trigger AFTER css /js has precompiiled
Rake::Task['assets:precompile'].enhance do
  Rake::Task['process_service_worker_cache'].invoke
end
