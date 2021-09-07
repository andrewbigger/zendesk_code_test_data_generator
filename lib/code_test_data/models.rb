require 'faker'
require 'securerandom'
require 'date'
require 'hashie'

MODELS = File.join(__dir__, 'models', '*.rb')

Dir[MODELS].sort.each do |file|
  require file
end

module CodeTestData
  # Test data generator model namespace
  module Models
  end
end
