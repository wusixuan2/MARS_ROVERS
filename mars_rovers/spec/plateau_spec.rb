require 'spec_helper'
require "plateau"

describe "Plateau Class" do
  before do
    @plateau = MARS_ROVERS::Plateau.new({x: 5, y: 5})
  end
  it "should initialize/set attr_reader for instance variable plateau_dimention with argument " do
    expect(@plateau.plateau_dimention).to eq({x: 5, y: 5})
    expect(@plateau.plateau_dimention[:x]).to eq(5)
    expect(@plateau.plateau_dimention[:y]).to eq(5)
  end

  it "should initialize/set attr_reader for instance variable occupied, default value is an empty array" do
    expect(@plateau.occupied).to eq([])
  end

end
