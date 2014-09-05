require_relative '../normal_distribution'
require_relative '../sampler'
require_relative '../input_time_series'
require_relative '../pulse_time_series'
require_relative '../rithm'
require_relative '../rithm_detector'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end
