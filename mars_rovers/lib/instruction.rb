module MARS_ROVERS
  class Instruction
    attr_reader :instructions, :final_list_rover
    def initialize(input)
      @instructions = input.split(/\n/) # convert the instructions from string to arrays
      @final_list_rover = [];
    end

  end
end