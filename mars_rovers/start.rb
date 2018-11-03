require './lib/instruction.rb'
require './lib/rover.rb'
require './lib/plateau.rb'
# require './lib/location.rb'
# require './lib/command.rb'

# orders = Instructions.new(ARGV.first)
# orders.create_world
# orders.process_robot_instructions


input = $stdin.readlines

puts 'finish reading'

x = input.first.split(' ')[0].strip.to_i
y = input.first.split(' ')[1].strip.to_i

instructions = input.to_a[1..-1].join

puts '>>>>>>>>> final coordinates and heading for rovers <<<<<<<<'




