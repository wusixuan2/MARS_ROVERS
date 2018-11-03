module MARS_ROVERS
  class Plateau
    attr_reader :x, :y
    def initialize(x, y)
      @x = x
      @y = y
      @occupied = [] # @occupied is an array of coordinates that are occupied by rovers
    end

    def add_rover(coordinate) # place existing rover on to the plateau
      @occupied.push(coordinate)
    end

    def plateau_valid? # check if the plateau is on the first quadrant
      if @x > 0 && @y > 0
        true
      else
        false
      end
    end

  end
end