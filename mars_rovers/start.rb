require './lib/instruction.rb'
require './lib/rover.rb'
require './lib/plateau.rb'

begin
  File.open("./test_input/#{ARGV[0]}")
rescue
  puts "failed to open #{ARGV[0]}\n"
  puts "check the file name and the file has to be inside test_input folder"
  exit
else
  sample_input = File.read("./test_input/#{ARGV[0]}")
  MARS_ROVERS::Instruction.new(sample_input).generate_output
end




