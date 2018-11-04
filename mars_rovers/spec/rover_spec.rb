require 'spec_helper'
require "rover"
require "plateau"

describe "Rover Class" do
  before do
    @plateau = MARS_ROVERS::Plateau.new({x: 5, y: 5})
    @Rover = MARS_ROVERS::Rover.new(@plateau, 1, 2, 'N')
  end
  context 'initializing' do
    it "should initialize/set attr_reader for plateau with first argument" do
      expect(@Rover.plateau).to eq(@plateau)
    end

    it "should initialize/set attr_reader for x with the 2nd argument" do
      expect(@Rover.x).to eq(1)
    end

    it "should initialize/set attr_reader for y with the 3rd argument" do
      expect(@Rover.y).to eq(2)
    end

    it "should initialize/set attr_reader for orientation with the 4th argument" do
      expect(@Rover.orientation).to eq('N')
    end
  end
end