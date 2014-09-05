require_relative '../normal_distribution'
require_relative '../sampler'
require_relative '../buffer'
require_relative '../function_smoother'
require_relative '../pattern_smoother'
require_relative '../pulse_detection'
require_relative '../pulse_time_series'
require_relative '../rithm'
require_relative '../rithm_detector'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end
