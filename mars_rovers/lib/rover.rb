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

    def forward_coordinate # return the coordinate in front of a rover
      case @orientation
      when 'N'
        @plateau.plateau_dimention[:y] === @y ? y = @y : y = @y + 1 # if moving out of edge, don't march
        return {x: @x, y: y}
      when 'W'
        @x === 0 ? x = @x : x = @x - 1
        return {x: x, y: @y}
      when 'S'
        @y === 0 ? y = @y : y = @y - 1
        return {x: @x, y: y}
      when 'E'
        @plateau.plateau_dimention[:x] === @x ? x = @x : x = @x + 1
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

    def march # move the rover on conditions
      if path_clear?
        @x = forward_coordinate[:x]
        @y = forward_coordinate[:y]
      end
    end

    def landing_inside? # check if the initial coordinate is inside the plateau
      if @x < 0 || @y < 0 || @x > @plateau.plateau_dimention[:x] || @y > @plateau.plateau_dimention[:y]
        false
      else
        true
      end
    end

    def landing_spot_empty? # check if the initial coordinate is taken or not
      @plateau.occupied.each do |rover|
        if @x === rover[:x] && @y === rover[:y]
          return false
        end
      end
      true
    end

  end
end