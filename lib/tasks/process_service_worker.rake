desc 'update the caching service worker file'
task process_service_worker_cache: :environment do

  puts 'Processing Service Worker'

  css_path = Rails.application.assets.find_asset('application.css').digest_path
  js_path = Rails.application.assets.find_asset('application.js').digest_path

  text_path = File.join((File.dirname(__FILE__), '../js/service_worker_client.js')
  text = File.read(text_path)

  new_file_path = File.join(file.dirname(__FILE__)'../public/serviceWorker.js')
  new_file = File.open(new_file_path, 'w')

  text.each_line do |line|
    if (line['application.css'])
      line = line.gsub! 'application.css', css_path
    end
    if (line['application.js'])
      line = line.gsub! 'application.js', js_path
    end
    new_file.puts line
  end
  new_file.close
end

# This should trigger AFTER css /js has precompiiled
Rake::Task['assets:precompile'].enhance do
  Rake::Task['process_service_worker_cache'].invoke
end
