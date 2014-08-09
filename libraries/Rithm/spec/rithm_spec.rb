require 'spec_helper'

describe Rithm do
  describe "#to_time_series" do
    subject { described_class.new([1,1,0,1,0,0,1,1],0.5) }
    it "returns the time_series of the rithm" do
      expect(subject.to_time_series).to eq [0.0, 0.5, 1.5, 3.0, 3.5]
    end
  end
end
