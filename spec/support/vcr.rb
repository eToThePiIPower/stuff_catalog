require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'fixtures/vcr_casettes'

  config.hook_into :webmock
end
