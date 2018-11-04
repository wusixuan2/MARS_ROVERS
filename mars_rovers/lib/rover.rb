module MARS_ROVERS
  class Rover
    attr_reader :x, :y, :orientation, :plateau
    def initialize(plateau, x, y, orientation)
      @plateau = plateau
      @x = x
      @y = y
      @orientation = orientation
    end

    def rotate(direction)
      if direction === 'L'
        case @orientation
        when 'N'
          @orientation = 'W'
        when 'W'
          @orientation = 'S'
        when 'S'
          @orientation = 'E'
        when 'E'
          @orientation = 'N'
        end
      else
        case @orientation
        when 'N'
          @orientation = 'E'
        when 'W'
          @orientation = 'N'
        when 'S'
          @orientation = 'W'
        when 'E'
          @orientation = 'S'
        end
      end
    end
  end
end