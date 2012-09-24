def RSpec.root
  @spec_root ||= Pathname.new(File.dirname(__FILE__))
end

$: << File.expand_path('../lib', File.dirname(__FILE__))

RSpec.configure do |config|
  config.mock_with :rspec
end

