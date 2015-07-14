require 'simplecov'
SimpleCov.start { add_filter '/spec' }

require 'bundler/setup'
Bundler.require

RSpec.configure do |config|
  config.profile_examples = 2
  config.order = :random
  config.tty = true
  Kernel.srand config.seed

  String.disable_colorization = true

  config.before do
    @stdout, $stdout = $stdout, StringIO.new unless ENV['RSPEC_DEBUG']
    @stderr, $stderr = $stderr, StringIO.new unless ENV['RSPEC_DEBUG']
  end

  config.after do
    $stdout, @stdout = @stdout, nil unless ENV['RSPEC_DEBUG']
    $stderr, @stderr = @stderr, nil unless ENV['RSPEC_DEBUG']
  end
end
