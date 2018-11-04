require 'spec_helper'
require "rover"
require "plateau"

describe "Rover Class" do
  before do
    @plateau = MARS_ROVERS::Plateau.new({x: 5, y: 5})
    @rover = MARS_ROVERS::Rover.new(@plateau, 1, 2, 'N')
  end
  context 'initializing' do
    it "should initialize/set attr_reader for plateau" do
      expect(@rover.plateau).to eq(@plateau)
    end

    it "should initialize/set attr_reader for x" do
      expect(@rover.x).to eq(1)
    end

    it "should initialize/set attr_reader for y" do
      expect(@rover.y).to eq(2)
    end

    it "should initialize/set attr_reader for orientation" do
      expect(@rover.orientation).to eq('N')
    end
  end

  context "instance method rotate" do
    before do
      @rover_west = MARS_ROVERS::Rover.new(@plateau, 1, 2, 'W')
      @rover_south = MARS_ROVERS::Rover.new(@plateau, 1, 2, 'S')
      @rover_east = MARS_ROVERS::Rover.new(@plateau, 1, 2, 'E')
    end
    it "should rotate to W when instructed with L and current orientation is N" do
      @rover.rotate('L')
      expect(@rover.orientation).to eq('W')
    end

    it "should rotate to S when instructed with L and current orientation is W" do
      @rover_west.rotate('L')
      expect(@rover_west.orientation).to eq('S')
    end

    it "should rotate to E when instructed with L and current orientation is S" do
      @rover_south.rotate('L')
      expect(@rover_south.orientation).to eq('E')
    end

    it "should rotate to N when instructed with L and current orientation is E" do
      @rover_east.rotate('L')
      expect(@rover_east.orientation).to eq('N')
    end

    it "should rotate to E when instructed with R and current orientation is N" do
      @rover.rotate('R')
      expect(@rover.orientation).to eq('E')
    end

    it "should rotate to N when instructed with R and current orientation is W" do
      @rover_west.rotate('R')
      expect(@rover_west.orientation).to eq('N')
    end

    it "should rotate to S when instructed with R and current orientation is E" do
      @rover_east.rotate('R')
      expect(@rover_east.orientation).to eq('S')
    end

    it "should rotate to W when instructed with R and current orientation is S" do
      @rover_south.rotate('R')
      expect(@rover_south.orientation).to eq('W')
    end
  end
end
