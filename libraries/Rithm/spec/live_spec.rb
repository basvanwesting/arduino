require 'spec_helper'

describe 'Live test' do

  describe "#play" do
    let!(:rithm)                { Rithm.new([1,1,1,1,0,1,0,1,0,1,1,1],0.05) }
    let!(:wrong_rithm)          { Rithm.new([1,1,1,1,0,1,0,1,1,0,1,1],0.05) }
    let!(:eventual_rithm) { Rithm.new([1,0,1,1,1,1,1,0,1,0,1,0,1,1,1],0.05) }
    let!(:rithm_detector) { RithmDetector.new(rithm) }

    it "plays SOS and matches valid on last beat" do
      rithm.play do
        rithm_detector.detect_beat!
        #puts "Beat! rithm matched? #{rithm_detector.valid?}"
      end
      expect(rithm_detector.valid?).to eq true
    end

    it "eventually plays SOS and matches valid on last beat" do
      eventual_rithm.play do
        rithm_detector.detect_beat!
        #puts "Beat! rithm matched? #{rithm_detector.valid?}"
      end
      expect(rithm_detector.valid?).to eq true
    end

    it "plays wrong rithm and never matches" do
      wrong_rithm.play do
        rithm_detector.detect_beat!
        #puts "Beat! rithm matched? #{rithm_detector.valid?}"
      end
      expect(rithm_detector.valid?).to eq false
    end
  end

end
