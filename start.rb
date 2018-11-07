require './lib/instruction.rb'
require './lib/rover.rb'
require './lib/plateau.rb'

# if ARGV === []
#   puts "Please specify a file name"
# else
#   begin
#     File.open("./test_input/#{ARGV[0]}")
#   rescue
#     puts "failed to open #{ARGV[0]}\n"
#     puts "check the file name and the file has to be inside test_input folder"
#     exit
#   else
#     sample_input = File.read("./test_input/#{ARGV[0]}")
#     MarsRovers::Instruction.new(sample_input).generate_output
#   end

# end

def check_input(input)
  if input === 'exit'
    MarsRovers::Instruction.new(@final_input).generate_output if input.length > 1
    exit
  else
    @final_input.push(input)
  end
end

@final_input = []
puts "type exit to exit the program"
puts "enter dimention of the plateau"

check_input(gets.chomp)

while true
  puts "enter location of rover"
  check_input(gets.chomp)

  puts "enter movement instruction"
  check_input(gets.chomp)
end






