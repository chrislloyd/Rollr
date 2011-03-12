$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'bundler'
Bundler.setup :test
Bundler.require :test

require 'json'
require 'tuml'
require 'thud'

FIXTURES = Pathname(__FILE__).dirname.join('fixtures')

module ThudSpecHelper

  def fixture *paths
    FIXTURES.join *paths
  end

end

RSpec.configure do |config|
  config.include ThudSpecHelper
  config.mock_with :rr

  config.before :all do
    FIXTURES.children(false).each do |path|
      name = path.basename '.*'
      data = JSON.parse fixture(path).read
      instance_variable_set "@#{name}", data
    end
  end
end
