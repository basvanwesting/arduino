require 'spec_helper'

describe Rithm do
  describe "#to_relative_pulse_timestamps" do
    subject { described_class.new([1,1,0,1,0,0,1,1],2) }
    it "returns the relative pulse_timestamps of the rithm" do
      expect(subject.to_relative_pulse_timestamps).to eq [0.0, 0.5, 1.5, 3.0, 3.5]
    end
  end

  describe "#play_function_proc" do

    context 'beats' do
      subject { described_class.new(pulses) }
      let(:timestamps) { 0.step(2,0.25).to_a }
      let(:pulses) { [1,1,1] }
      let(:output) { [3.99, 0.18, 0, 0.18, 3.99, 0.18, 0, 0.18, 3.99] }

      it 'returns an output stream' do
        play_function_proc = subject.play_function_proc
        values = timestamps.map do |timestamp|
          play_function_proc.call(timestamp + subject.proc_created_at)
        end
        values.zip(output).each do |actual, expected|
          actual.should be_within(0.01).of(expected)
        end
      end
    end

    #context 'beats' do
      #subject { described_class.new(pulses, 11) }
      #let(:timestamps) { 0.step(1,0.00909).to_a }
      #let(:pulses) { [1,1,1,1,0,1,0,1,0,1,1,1] }
      #let(:output) { [3.99, 0.18, 0, 0.18, 3.99, 0.18, 0, 0.18, 3.99] }

      #it 'returns an output stream' do
        #play_function_proc = subject.play_function_proc
        #values = timestamps.map do |timestamp|
          #play_function_proc.call(timestamp + subject.proc_created_at)
        #end
        #puts values
        #values.zip(output).each do |actual, expected|
          #actual.should be_within(0.01).of(expected)
        #end
      #end
    #end
  end
end

describe "play rithm live test", slow: true do

  let!(:rithm) { Rithm.new([1,1,1,1,0,1,0,1,0,1,1,1],22) }

  it "plays SOS" do
    array = []
    start_time = Time.now
    rithm.play do
      array << 1
      puts "Beat!"
    end
    end_time = Time.now

    (end_time.to_f - start_time.to_f).should be_within(0.1).of(0.5)
    array.should == [1] * 9
  end

end
