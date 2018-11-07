module MarsRovers
  class Plateau
    attr_reader :plateau_dimention, :occupied

    def initialize(plateau_dimention)
      @plateau_dimention = plateau_dimention
      @occupied = [] # @occupied is an array of coordinates that are occupied by rovers
    end

    def add_rover(coordinate) # place existing rover on to the plateau
      if coordinate[:x] <= @plateau_dimention[:x] &&
        coordinate[:y] <= @plateau_dimention[:y] &&
        coordinate[:x] >= 0 &&
        coordinate[:y] >= 0
        @occupied.push(coordinate)
      end
    end

    def plateau_valid? # check if the plateau is on the first quadrant or on (0, 0)
      @plateau_dimention[:x] >= 0 && @plateau_dimention[:y] >= 0 ? true : false
    end
  end
end