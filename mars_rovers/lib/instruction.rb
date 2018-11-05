module MARS_ROVERS
  class Instruction
    attr_reader :instructions, :final_list_rover, :plateau, :processed_instructions
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

  end
end