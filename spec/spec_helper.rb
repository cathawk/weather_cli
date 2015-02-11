require 'webmock/rspec'
require 'vcr'
require_relative '../weather'


VCR.configure do |config|
  config.cassette_library_dir = "spec/support/vcr"
  config.hook_into :webmock
end
