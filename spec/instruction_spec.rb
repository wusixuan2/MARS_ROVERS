require 'spec_helper'
require "rover"
require "plateau"
require "instruction"

describe "Instruction Class" do
  before do
    sample_input = "5 5\n1 2 N\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM"
    @instruction = MarsRovers::Instruction.new(sample_input)
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
      expect(@instruction.plateau).to be_an_instance_of(MarsRovers::Plateau)
    end

    it "exit if invalid plateau" do
      invalid_input = "-5 5\n1 2 N\nLMLMLMLMM"
      @invalid_instruction = MarsRovers::Instruction.new(invalid_input)
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

  describe "#read_instruction" do
    before do
      @instruction.read_instruction
    end
    it "invoke create_plateau" do
      expect(@instruction.plateau).to be_an_instance_of(MarsRovers::Plateau)
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
        expect(@instruction.current_rover).to be_an_instance_of(MarsRovers::Rover)
      end

      it "invoke move_rover" do
        expect(@instruction.current_rover.x).to eq(5)
        expect(@instruction.current_rover.y).to eq(1)
        expect(@instruction.current_rover.orientation).to eq('E')
      end
    end
  end

  describe "#generate_output" do
    it 'print result' do
      expected_output =  "1 3 N\n5 1 E\n"
      expect do
        @instruction.generate_output
      end.to output(expected_output).to_stdout
    end
  end

  describe "#create_rover" do
    before do
      @instruction.read_instruction
      # after invoking read_instruction on @instruction
      # @current_rover_instruction = "3 3 E"
      # @current_move_instruction "MMRMMRMRRM"
      # @current_rover location: 5 1 E
    end
    it "create new rover instance" do
      @instruction.create_rover
      expect(@instruction.current_rover).to be_an_instance_of(MarsRovers::Rover)
    end

    it "rover's dimention is based on instruction" do
      expect(@instruction.current_rover.x).to eq(5)
      expect(@instruction.current_rover.y).to eq(1)
      expect(@instruction.current_rover.orientation).to eq('E')
    end

    it "if valid? return false, set rover instance to null" do
      invalid_input = "5 5\n-1 2 N\nLMLMLMLMM"
      @instruction1 = MarsRovers::Instruction.new(invalid_input)
      @instruction1.read_instruction
      # after invoking read_instruction on @instruction1
      # @current_rover location: -1 2 N
      expect(@instruction1.current_rover).to eq(nil)
    end
  end

  describe "#add_rover_coordinate" do
    it "update final_list_rover" do
      @instruction.read_instruction
      expect(@instruction.final_list_rover).to eq(["1 3 N", "5 1 E"])
    end
  end

  describe "#move_rover" do
    before do
      @instruction.read_instruction
      # after invoking read_instruction on @instruction
      # @current_rover_instruction = "3 3 E"
      # @current_move_instruction "MMRMMRMRRM"
      # @current_rover location: 5 1 E
      invalid_move = "5 5\n1 2 N\n\n"
      @instruction_invalid_move = MarsRovers::Instruction.new(invalid_move)
      @instruction_invalid_move.read_instruction
      # after invoking read_instruction on @instruction_invalid_move
      # @current_rover_instruction = "1 2 N"
      # @current_move_instruction "\n"
      # @current_rover location: 1 2 N

    end
    context "instruct rover" do
      it "move rover when valid rover and valid instruction" do
        @instruction.move_rover # move rover base on @current_move_instruction "MMRMMRMRRM" and @current_rover location: 5 1 E
        expect(@instruction.current_rover.x).to eq(5)
        expect(@instruction.current_rover.y).to eq(0)
        expect(@instruction.current_rover.orientation).to eq('E')
      end

      it "don't move rover when valid rover and invalid instruction" do
        @instruction_invalid_move.move_rover # move rover base on @current_move_instruction "\n" and @current_rover location: 1 2 N
        expect(@instruction_invalid_move.current_rover.x).to eq(1)
        expect(@instruction_invalid_move.current_rover.y).to eq(2)
        expect(@instruction_invalid_move.current_rover.orientation).to eq('N')
      end
    end

    it "invoke add_rover_coordinate" do
      expect(@instruction.final_list_rover).to eq(["1 3 N", "5 1 E"])
      @instruction.move_rover
      expect(@instruction.final_list_rover).to eq(["1 3 N", "5 1 E", "5 0 E"])
    end

    it "invoke add_rover on instance plateau" do
      expect(@instruction.plateau.occupied).to eq([{:x=>1, :y=>3}, {:x=>5, :y=>1}])
      @instruction.move_rover
      expect(@instruction.plateau.occupied).to eq([{:x=>1, :y=>3}, {:x=>5, :y=>1}, {:x=>5, :y=>0}])
    end
  end

end
