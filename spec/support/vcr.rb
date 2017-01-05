require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.configure_rspec_metadata!
  c.default_cassette_options = { record: :new_episodes }
  c.filter_sensitive_data('<GMAN_SERVICES_URL>') { ENV['GMAN_SERVICES_URL'] }
  c.filter_sensitive_data('<GMAN_SERVICES_CLIENT_ID>') do
    ENV['GMAN_SERVICES_CLIENT_ID']
  end
  c.filter_sensitive_data('<GMAN_SERVICES_CLIENT_SECRET>') do
    ENV['GMAN_SERVICES_CLIENT_SECRET']
  end
  c.hook_into :webmock
  c.ignore_hosts 'codeclimate.com'
end
