module MARS_ROVERS
  class Instruction
    def initialize(input)
      @instructions = input.split(/\n/) # convert the instructions from string to arrays
      @final_list_rover = [];
    end

    def create_plateau
      x = @instructions.first.split(' ')[0].to_i
      y = @instructions.first.split(' ')[1].to_i
      plateau_dimention = {x: x, y: y}
      @plateau = Plateau.new(plateau_dimention, [])
      if !@plateau.plateau_valid?
        puts 'Invalid plateau coordinate'
        exit
      end
    end

    def process_instructions # group instruction for each rover
      rover_tracker = 0 # keep track of number of rovers
      @processed_instructions = []
      @instructions.drop(1).each_with_index do |instruction, index|
        if index % 2 === 0 # instructions for coordinate and orientation of rovers
          @processed_instructions.push([instruction])
        else # instruction for moving the rovers
          @processed_instructions[rover_tracker].push(instruction)
          rover_tracker += 1
        end
      end
    end

    def create_rover # return a rover instance with a line of input of coordinates and orientation
      x = @current_rover_instruction.split(' ')[0].to_i
      y = @current_rover_instruction.split(' ')[1].to_i
      orientation = @current_rover_instruction.split(' ')[2]
      @current_rover = Rover.new(@plateau, x, y, orientation)
      if !@current_rover.valid? # if the rover lands on another rover or outside plateau, ignore it
        @current_rover = nil
      end
    end

    def add_rover_coordinate
      @final_list_rover.push(@current_rover.x.to_s + ' ' + @current_rover.y.to_s + ' ' + @current_rover.orientation.to_s)
    end

    def move_rover # read moving instruction and return coordinate and orientation for one rover
      if @current_rover && @current_move_instruction # if the rover lands succesfully and instruction for moving exist
        @current_move_instruction.split('').each do |move|
          if move === 'L' || move === 'R'
            @current_rover.rotate(move)
          elsif move === 'M'
            @current_rover.march
          end
        end
        add_rover_coordinate
        @plateau.add_rover({x: @current_rover.x, y: @current_rover.y })
      elsif @current_rover
        add_rover_coordinate
        @plateau.add_rover({x: @current_rover.x, y: @current_rover.y })
      end
    end

    def generate_output
      create_plateau
      process_instructions
      @processed_instructions.map do |instruction|
        @current_rover_instruction = instruction[0]
        @current_move_instruction = instruction[1]
        create_rover
        move_rover
      end
      puts @final_list_rover
      return
    end
  end
end
