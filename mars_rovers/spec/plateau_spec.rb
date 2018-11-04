require 'spec_helper'
require "plateau"

describe "Plateau Class" do
  before do
    @plateau = MARS_ROVERS::Plateau.new({x: 5, y: 5})
  end
  describe 'initializing' do
    it "should initialize/set attr_reader for instance variable plateau_dimention with argument" do
      expect(@plateau.plateau_dimention).to eq({x: 5, y: 5})
    end

    it "should initialize/set attr_reader for instance variable occupied, default value is an empty array" do
      expect(@plateau.occupied).to eq([])
    end
  end

  describe '#add_rover' do
    it "should add coordinate to occupied if coordinate is inside the plateau" do
      @plateau.add_rover({x: 2, y: 2})
      expect(@plateau.occupied).to eq([{x: 2, y: 2}])
    end

    it "should add coordinate to occupied if coordinate is on the edge of plateau" do
      @plateau.add_rover({x: 0, y: 0})
      @plateau.add_rover({x: 5, y: 5})
      expect(@plateau.occupied).to eq([{x: 0, y: 0}, {x: 5, y: 5}])
    end

    it "should not add coordinate to occupied if coordinate is outside of plateau" do
      @plateau.add_rover({x: 10, y: -1})
      expect(@plateau.occupied).to eq([])
    end
  end

  describe '#plateau_valid?' do
    before do
      @invalid_plateau = MARS_ROVERS::Plateau.new({x: -5, y: 5})
      @valid_plateau = MARS_ROVERS::Plateau.new({x: 0, y: 0})
    end
    it "should return true if the plateau is in the first quadrant" do
      expect(@plateau.plateau_valid?).to eq(true)
    end

    it "should return true if the plateau is only on the point (0, 0)" do
      expect(@valid_plateau.plateau_valid?).to eq(true)
    end

    it "should return false if plateau is outside the first quadrant or on (0,0)" do
      expect(@invalid_plateau.plateau_valid?).to eq(false)
    end
  end
end
