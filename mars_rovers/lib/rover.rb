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

    def move_forward
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

    def path_clear?

    end

    def landing_outside?
    end

    def outbound?
    end

  end

end