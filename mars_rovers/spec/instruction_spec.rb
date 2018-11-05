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

  describe "#process_instructions" do
    it "should create and update processed_instructions" do
      @instruction.process_instructions
      expect(@instruction.processed_instructions).to eq([["1 2 N", "LMLMLMLMM"], ["3 3 E", "MMRMMRMRRM"]])
    end
  end

  describe "#generate_output" do
    before do
      @instruction.generate_output
    end
    it "invoke create_plateau" do
      expect(@instruction.plateau).to be_an_instance_of(MARS_ROVERS::Plateau)
    end

    it "invoke process_instructions" do
      expect(@instruction.processed_instructions).to eq([["1 2 N", "LMLMLMLMM"], ["3 3 E", "MMRMMRMRRM"]])
    end
    context "loop through processed_instructions" do
      it "update current_rover_instruction" do
        expect(@instruction.current_rover_instruction).to eq("3 3 E")
      end

      it "update current_move_instruction" do
        expect(@instruction.current_move_instruction).to eq("MMRMMRMRRM")
      end

      it "invoke create_rover" do
        expect(@instruction.current_rover).to be_an_instance_of(MARS_ROVERS::Rover)
      end

      it "invoke move_rover" do
        expect(@instruction.current_rover.x).to eq(4)
        expect(@instruction.current_rover.y).to eq(3)
        expect(@instruction.current_rover.orientation).to eq('E')
      end
    end
  end

  describe "final output" do
    it 'print result' do
      expected_output =  "1 3 N\n4 3 E\n"
      expect do
        @instruction.generate_output
      end.to output(expected_output).to_stdout
    end
  end

  describe "#create_rover" do
    before do
      @instruction.generate_output
    end
    it "create new rover instance" do
      @instruction.create_rover
      expect(@instruction.current_rover).to be_an_instance_of(MARS_ROVERS::Rover)
    end

    it "rover's dimention is based on instruction" do
      expect(@instruction.current_rover.x).to eq(4)
      expect(@instruction.current_rover.y).to eq(3)
      expect(@instruction.current_rover.orientation).to eq('E')
    end

    it "if valid? return false, set rover instance to null" do
      invalid_input = "5 5\n-1 2 N\nLMLMLMLMM"
      @instruction1 = MARS_ROVERS::Instruction.new(invalid_input)
      @instruction1.generate_output
      expect(@instruction1.current_rover).to eq(nil)
    end
  end

  describe "#add_rover_coordinate" do
    it "update final_list_rover" do
      @instruction.generate_output
      expect(@instruction.final_list_rover).to eq(["1 3 N", "4 3 E"])
    end
  end

end
