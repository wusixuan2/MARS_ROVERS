module MARS_ROVERS
class Instruction
  def initialize(input)
    @instructions = input.to_a[1..-1].join
    @x = input.first.split(' ')[0].strip.to_i
    @y = input.first.split(' ')[1].strip.to_i
  end

  def create_plateau
    @plateau = Plateau.new(@x, @y)
  end

  def generate_output
  end
end

end