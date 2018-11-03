require './lib/instruction.rb'
require './lib/rover.rb'
require './lib/plateau.rb'

# input = $stdin.readlines

# puts '>>>>>>>>> final coordinates and heading for rovers <<<<<<<<'
# MARS_ROVERS::Instruction.new(input).generate_output


# puts rover.move_forward
# puts rover.inspect

plateau = MARS_ROVERS::Plateau.new(5, 5, [{x: 1, y: 1},{x: 1, y:2}])

rover = MARS_ROVERS::Rover.new(plateau, 0, 1, 'E')

puts rover.path_clear?