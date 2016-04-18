desc 'update the caching service worker file'
task process_service_worker: :environment do

  puts 'Processing Service Worker'

  css_path = Rails.application.assets.find_asset('application.css').digest_path
  js_path = Rails.application.assets.find_asset('application.js').digest_path

  text = File.read(File.dirname(__FILE__) + '/js/service_worker_client.js')
  new_file = File.open('./public/serviceWorker.js', 'w')

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
  Rake::Task['process_service_worker'].invoke
end
