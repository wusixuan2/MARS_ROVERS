require 'spec_helper'
require "plateau"

describe "Plateau Class" do
  before do
    @plateau = MarsRovers::Plateau.new({x: 5, y: 5})
  end
  context 'initializing' do
    it "should initialize/set attr_reader for plateau_dimention" do
      expect(@plateau.plateau_dimention).to eq({x: 5, y: 5})
    end

    it "should initialize/set attr_reader for occupied" do
      expect(@plateau.occupied).to eq([])
    end
  end

  describe '#add_rover' do
    it "should add coordinate to occupied if rover is inside the plateau" do
      @plateau.add_rover({x: 2, y: 2})
      expect(@plateau.occupied).to eq([{x: 2, y: 2}])
    end

    it "should add coordinate to occupied if rover is on the edge of plateau" do
      @plateau.add_rover({x: 0, y: 0})
      @plateau.add_rover({x: 5, y: 5})
      expect(@plateau.occupied).to eq([{x: 0, y: 0}, {x: 5, y: 5}])
    end

    it "should not add coordinate to occupied if rover is outside of plateau" do
      @plateau.add_rover({x: 10, y: -1})
      expect(@plateau.occupied).to eq([])
    end
  end

  describe '#plateau_valid?' do
    before do
      @invalid_plateau = MarsRovers::Plateau.new({x: -5, y: 5})
      @valid_plateau = MarsRovers::Plateau.new({x: 0, y: 0})
    end
    it "should return true if plateau is in first quadrant" do
      expect(@plateau.plateau_valid?).to eq(true)
    end

    it "should return true if plateau is on (0, 0)" do
      expect(@valid_plateau.plateau_valid?).to eq(true)
    end

    it "should return false otherwise" do
      expect(@invalid_plateau.plateau_valid?).to eq(false)
    end
  end
end
