require './lib/instruction.rb'
require './lib/rover.rb'
require './lib/plateau.rb'

sample_input = "5 5\n1 2 N\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM" # OUTPUT: 1 3 N\n5 1 E

sample_input1 = "8 8
0 0 N
LLLLMMMMLMRMR
8 8 S
LMLLM
3 3 S

5 5 W
L
4 0 S
LR
-2 -2 W
MMM"

#0 5 E
#7 8 W
#3 3 S
#5 5 S
#4 0 S
sample_input2 = "3 3
1 2 S
LR
1 1 N
M
3.2 3 N"
sample_input3 = "4 4
5 5 N
LRLRM
2 2 S
R
2 2 N
R"
sample_input4 = "0 0
1 1 S
LRLR
0 0 N
MM"
MARS_ROVERS::Instruction.new(sample_input1).generate_output
# puts '>>>>>>>>>>>>>>2'
# MARS_ROVERS::Instruction.new(sample_input2).generate_output
# puts '>>>>>>>>>>>>>>3'
# MARS_ROVERS::Instruction.new(sample_input3).generate_output
# puts '>>>>>>>>>>>>>>4'
# MARS_ROVERS::Instruction.new(sample_input4).generate_output


