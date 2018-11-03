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

    def march # move the rover
      case @orientation
      when 'N'
        @plateau.y === @y ? @y : @y = @y + 1
      when 'W'
        @x === 0 ? @x : @x = @x - 1
      when 'S'
        @y === 0 ? @y : @y = @y - 1
      when 'E'
        @plateau.x === @x ? @x : @x = @x + 1
      end
    end

    def forward_coordinate # return the coordinate in front of a rover
      case @orientation
      when 'N'
        @plateau.y === @y ? y = @y : y = @y + 1
        return {x: @x, y: y}
      when 'W'
        @x === 0 ? x = @x : x = @x - 1
        return {x: x, y: @y}
      when 'S'
        @y === 0 ? y = @y : y = @y - 1
        return {x: @x, y: y}
      when 'E'
        @plateau.x === @x ? x = @x : x = @x + 1
        return {x: x, y: @y}
      end
    end

    def path_clear? # check if the spot in front of the rover is occupied or not
      @plateau.occupied.each do |rover|
        if forward_coordinate[:x] === rover[:x] && forward_coordinate[:y] === rover[:y]
          return false
        end
      end
      true
    end

    def landing_inside?
      if @x < 0 || @y < 0
        false
      else
        true
      end
    end
  end

end