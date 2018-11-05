require 'spec_helper'
# require "rover"
# require "plateau"
require "instruction"

describe "Instruction Class" do
  before do
    # @plateau = MARS_ROVERS::Plateau.new({x: 5, y: 5})
    # @rover = MARS_ROVERS::Rover.new(@plateau, 1, 2, 'N')
    # @rover2 = MARS_ROVERS::Rover.new(@plateau, 3, 3, 'E')
    sample_input = "5 5\n1 2 N\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM"
    @instruction = MARS_ROVERS::Instruction.new(sample_input)
  end

  context 'initializing' do
    it "should initialize instructions" do
      puts @instruction.instructions
      expect(@instruction.instructions).to eq(["5 5", "1 2 N", "LMLMLMLMM", "3 3 E", "MMRMMRMRRM"])
    end

    it "should initialize final_list_rover" do
      expect(@instruction.final_list_rover).to eq([])
    end
  end

end