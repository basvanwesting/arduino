require 'spec_helper'

describe Sampler do

  describe '#to_input_time_series' do
    subject do
      described_class.new(start_timestamp: 0, end_timestamp: 2, frequency: 4)
    end

    context 'single function' do
      let(:expected) do
        [
          [0.0, 0.0],
          [0.25, 0.0625],
          [0.5, 0.25],
          [0.75, 0.5625],
          [1.0, 1.0],
          [1.25, 1.5625],
          [1.5, 2.25],
          [1.75, 3.0625],
          [2.0, 4.0],
        ]
      end

      it 'returns the input time series' do
        actual = subject.call( Proc.new { |x| x**2 } )
        actual.should == expected
      end
    end

    context 'multiple functions' do
      let(:expected) do
        [
          [0.0, 0.0],
          [0.25, -0.1875],
          [0.5, -0.25],
          [0.75, -0.1875],
          [1.0, 0.0],
          [1.25, 0.3125],
          [1.5, 0.75],
          [1.75, 1.3125],
          [2.0, 2.0],
        ]
      end

      it 'returns the input time series' do
        actual = subject.call( *[Proc.new { |x| x**2 }, Proc.new { |x| -x }] )
        actual.should == expected
      end
    end

  end

  describe '#sample' do
    subject { described_class.new(frequency: 8) }
    let(:function) { double }

    before do
      allow(function).to receive(:call).and_return(1,2,3)
      allow(subject).to receive(:delay_to_next_sample).and_return(0)
      allow(subject).to receive(:current_time).and_return(0)
    end

    it 'builds up input time series' do
      subject.input_time_series.should == []
      subject.sample(function)
      subject.input_time_series.should == [[0,1]]
      subject.sample(function)
      subject.input_time_series.should == [[0,1], [0,2]]
      subject.sample(function)
      subject.input_time_series.should == [[0,1], [0,2], [0,3]]
    end

  end

end

describe 'Sampler Live test', slow: true do

  subject { Sampler.new(frequency: 4) }
  let(:function) { double }

  before do
    allow(function).to receive(:call).and_return(2,4,3,5,4,6)
  end

  let(:expected) do
    [
      [0.0,  2],
      [0.25, 4],
      [0.5,  3],
      [0.75, 5],
      [1.0,  4],
      [1.25, 6],
    ]
  end

  it 'samples the provided function at requested frequency, blocks if too soon' do
    6.times { subject.sample(function) }

    first_timestamp = subject.input_time_series.first.first

    actual = subject.input_time_series.map do |timestamp, value|
      [timestamp.to_f - first_timestamp.to_f, value]
    end

    [actual, expected].transpose.each do |(actual_timestamp, actual_value), (expected_timestamp, expected_value)|
      actual_timestamp.should be_within(0.005).of(expected_timestamp)
      actual_value.should == expected_value
    end
  end

end
