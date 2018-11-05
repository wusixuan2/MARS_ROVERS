module MARS_ROVERS
  class Instruction
    attr_reader :instructions, :final_list_rover, :plateau, :processed_instructions, :current_rover, :current_rover_instruction, :current_move_instruction
    def initialize(input)
      @instructions = input.split(/\n/) # convert the instructions from string to arrays
      @final_list_rover = [];
    end

    def create_plateau
      x = @instructions.first.split(' ')[0].to_i
      y = @instructions.first.split(' ')[1].to_i
      plateau_dimention = {x: x, y: y}
      @plateau = Plateau.new(plateau_dimention)
      if !@plateau.plateau_valid?
        puts 'Invalid plateau coordinate'
        exit
      end
    end

    def process_instructions # group instruction for each rover
      rover_tracker = 0 # keep track of number of rovers and use it as the index for @processed_instructions
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

    def create_rover
      x = @current_rover_instruction.split(' ')[0].to_i
      y = @current_rover_instruction.split(' ')[1].to_i
      orientation = @current_rover_instruction.split(' ')[2]
      @current_rover = Rover.new(@plateau, x, y, orientation)
    end

    def add_rover_coordinate
      @final_list_rover.push(@current_rover.x.to_s + ' ' + @current_rover.y.to_s + ' ' + @current_rover.orientation.to_s)
    end

    def move_rover
      @current_rover.march
      add_rover_coordinate
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