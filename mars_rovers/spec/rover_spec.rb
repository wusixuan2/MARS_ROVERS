require 'spec_helper'
require "rover"
require "plateau"

describe "Rover Class" do
  before do
    @plateau = MARS_ROVERS::Plateau.new({x: 5, y: 5})
    @rover = MARS_ROVERS::Rover.new(@plateau, 1, 2, 'N')
    @rover_west = MARS_ROVERS::Rover.new(@plateau, 2, 2, 'W')
    @rover_south = MARS_ROVERS::Rover.new(@plateau, 1, 2, 'S')
    @rover_east = MARS_ROVERS::Rover.new(@plateau, 1, 5, 'E')
    @rover_north_edge = MARS_ROVERS::Rover.new(@plateau, 2, 5, 'N')
    @rover_west_edge = MARS_ROVERS::Rover.new(@plateau, 0, 1, 'W')
    @rover_south_edge = MARS_ROVERS::Rover.new(@plateau, 1, 0, 'S')
    @rover_east_edge = MARS_ROVERS::Rover.new(@plateau, 5, 2, 'E')
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

  context "instance method forward_coordinate" do
    it "should return coordinate in front of rover when it's inside plateau" do
      expect(@rover.forward_coordinate).to eq({x: 1, y: 3})
      expect(@rover_west.forward_coordinate).to eq({x: 1, y: 2})
      expect(@rover_south.forward_coordinate).to eq({x: 1, y: 1})
      expect(@rover_east.forward_coordinate).to eq({x: 2, y: 5})
    end

    it "should return rover's coordinate when it's on the edge of plateau" do
      expect(@rover_north_edge.forward_coordinate).to eq({x: 2, y: 5})
      expect(@rover_west_edge.forward_coordinate).to eq({x: 0, y: 1})
      expect(@rover_south_edge.forward_coordinate).to eq({x: 1, y: 0})
      expect(@rover_east_edge.forward_coordinate).to eq({x: 5, y: 2})
    end
  end

  context "instance method path_clear?" do
    it "should return true if spot in front of rover is not occupied by another rover" do
      expect(@rover.path_clear?).to eq(true)
      expect(@rover_south.path_clear?).to eq(true)
    end

    it "should return false if spot in front of rover is occupied by another rover" do
      @plateau.add_rover({x: 1, y: 2})
      @plateau.add_rover({x: 2, y: 5})
      expect(@rover_west.path_clear?).to eq(false)
      expect(@rover_east.path_clear?).to eq(false)
    end
  end

  context "instance method march" do
    it "should update x and y if path_clear? return true" do
      @rover.march
      @rover_north_edge.march
      expect(@rover.x).to eq(1)
      expect(@rover.y).to eq(3)
      expect(@rover_north_edge.x).to eq(2)
      expect(@rover_north_edge.y).to eq(5)
    end

    it "should not update x and y if path_clear? return true" do
      @plateau.add_rover({x: 1, y: 2})
      @plateau.add_rover({x: 2, y: 5})
      @rover_west.march
      @rover_east.march
      expect(@rover_west.x).to eq(2)
      expect(@rover_west.y).to eq(2)
      expect(@rover_east.x).to eq(1)
      expect(@rover_east.y).to eq(5)
    end
  end

end
