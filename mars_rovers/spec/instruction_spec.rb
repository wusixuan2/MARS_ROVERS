require 'spec_helper'
require "rover"
require "plateau"
require "instruction"

describe "Instruction Class" do
  before do
    sample_input = "5 5\n1 2 N\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM"
    @instruction = MARS_ROVERS::Instruction.new(sample_input)
  end

  context 'initializing' do
    it "should initialize instructions" do
      expect(@instruction.instructions).to eq(["5 5", "1 2 N", "LMLMLMLMM", "3 3 E", "MMRMMRMRRM"])
    end

    it "should initialize final_list_rover" do
      expect(@instruction.final_list_rover).to eq([])
    end
  end

  describe "#create_plateau" do
    it "create new plateau instance" do
      @instruction.create_plateau
      expect(@instruction.plateau).to be_an_instance_of(MARS_ROVERS::Plateau)
    end

    it "exit if invalid plateau" do
      invalid_input = "-5 5\n1 2 N\nLMLMLMLMM"
      @invalid_instruction = MARS_ROVERS::Instruction.new(invalid_input)
      expect { @invalid_instruction.create_plateau }.to raise_error(SystemExit)
    end

    it "plateau's dimention is based on instruction" do
      @instruction.create_plateau
      expect(@instruction.plateau.plateau_dimention[:x]).to eq(5)
      expect(@instruction.plateau.plateau_dimention[:y]).to eq(5)
    end
  end

end