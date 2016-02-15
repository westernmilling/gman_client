require 'vcr'

real_requests = ENV['VCR_ALLOW_ACTUAL_REQUESTS']

VCR.configure do |c|
  c.allow_http_connections_when_no_cassette = true if real_requests
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

RSpec.configure do |config|
  config.before(:each) do
    VCR.eject_cassette
  end if real_requests
end
