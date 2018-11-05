module MARS_ROVERS
  class Instruction
    attr_reader :instructions, :final_list_rover, :plateau
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

  end
end