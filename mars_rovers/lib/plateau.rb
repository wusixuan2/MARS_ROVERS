module MARS_ROVERS
  class Plateau
    attr_reader :plateau_dimention, :occupied
    def initialize(plateau_dimention)
      @plateau_dimention = plateau_dimention
      @occupied = [] # @occupied is an array of coordinates that are occupied by rovers
    end

  end
end