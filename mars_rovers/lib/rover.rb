module MARS_ROVERS
  class Rover
    attr_reader :x, :y, :orientation, :plateau
    def initialize(plateau, x, y, orientation)
      @plateau = plateau
      @x = x
      @y = y
      @orientation = orientation
    end
  end
end