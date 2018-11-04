module MARS_ROVERS
  class Plateau
    attr_reader :plateau_dimention, :occupied
    def initialize(plateau_dimention, occupied)
      @plateau_dimention = plateau_dimention
      @occupied = occupied # @occupied is an array of coordinates that are occupied by rovers
    end

    def add_rover(coordinate) # place existing rover on to the plateau
      @occupied.push(coordinate)
    end

    def plateau_valid? # check if the plateau is on the first quadrant
      if @plateau_dimention[:x] >= 0 && @plateau_dimention[:y] >= 0
        true
      else
        false
      end
    end
  end
end