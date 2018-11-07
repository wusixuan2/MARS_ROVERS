# mars rovers coding challenge

To run the solution: 
1. Clone this project with git clone 
2. cd mars-rover
3. cd mars-rover
4. gem install rspec
5. rspec
6. ruby start.rb [ name of the text file ]   #example: ruby start.rb test_input.txt 
(the test input file is located in folder test_input)

My approach:

Class Plateau:
instance variable:
- plateau_dimention: a hash with x y coordinate of the plateau
- occupied: an array of coordinates that are occupied by rovers

instance method:
- add_rover(coordinate) add coordinate to occupied
- plateau_valid? check if the plateau is on the first quadrant or on (0, 0)

Class Rover:
instance variable:
- x
- y
- orientation
- plateau: a plateau instance

instance method:
- rotate(direction)  update @orientation based on direction and current value of @orientation
- forward_coordinate: return the coordinate in front of a rover
- path_clear?: check if the spot in front of the rover is occupied or not
- march:  move the rover(update @x @y @orientaion) on conditions
- landing_inside? : check if the initial coordinate is inside the plateau
- landing_spot_empty? : check if the initial coordinate is taken or not
- valid? : check if both landing_inside? and landing_spot_empty? return true

Class Instruction:
instance variable:
- instructions : an array of instructions from the input text file
- final_list_rover : storing array of rover coordinate that has been placed and moved
- plateau : a plateau instance
- processed_instructions : an array of arrays of 2 instructions for rover location and movement
- current_rover : an rover instance
- current_rover_instruction :a string of instruction for rover location
- current_move_instruction :a string of instruction for rover movement

instance method:
- create_plateau: create an plateau instance based on the first line of instruction, create @plateau 
- process_instructions: iterate through @instructions and group instructions of 2 for each rover, store it in @processed_instructions
- create_rover: create rover instance based on @current_rover_instruction, store it in @current_rover
- add_rover_coordinate: add coordinate to @final_list_rover
- move_rover: update rover instance's coordinate based on @current_move_instruction
- read_instruction: iterate through @processed_instructions and update @current_rover_instruction and @current_move_instruction, calls create_rover, move_rover in each iteration
- generate_output: print final_list_rover


My thought process: 

// planning:
I decide to use TDD and focus on OOP while solving this problem. I use TDD because I want to produce clean, maintainable code. I focus on OOP because it’s intuitive to use classes and instances to keep track of each rover and their property. And I'll follow red-green-refractor for the testing.

I learned RSpec but I have no hand on experience with TDD, so i decide to write the solution out first, get a general idea of the solution and start over with TDD. and I’ll be able to refractor the code along the way.

the question has two entity to keep track of: rovers and plateau, so I would have 2 classes for them. I'll also need a set of instance method to update properties of them. I'll also create a class intruction to process the input and produce output.

As i was writing sample input and testing case, I made some assumption: 1. rover can only stay inside and on the edge of the grid. if they try to move outside, then the movement will not be executed. if they land outside the gird, it will be ignored 2. the rover cannot occupy the same spot. for each input, if the new rover’s starting location is already been occupied, then it is skipped. if there’s an existing rover in front of a rover that’s moving toward that direction, then the rover stay in place unless the direction change and the path is clear. 3. to generate the output, make sure all the rover instances have been generated before starting the movement. 4. since first line of input is the upper-right coordinates of the plateau, the plateau can only be in the 1st quadrant or on (0, 0). 

// during writing the solition

some note: 
1. I was using $stdin.readlines to read input but change it to read text file instead. 

2. In class instruction, when I was writing instance method create_rover, I pass an argument of instruction string to the method. But I wanted to make it more cleaner and more dynamic, so I changed it to read @current_rover_instruction (an instance variable storing a string of instruction update by instance method read_instruction), to make it easier to track. I repeat the same process with instance method move_rover, which then takes @current_rover(an instance variable created and updated by create_rover) and @current_move_instruction(update by read_instruction). 

3. Same thought process as above, As I loop the instruction and assign it to either create_rover or move_rover, I change it so that it updates instance variable @current_rover_instruction and @current_move_instruction. after it update, the method calls create_rover and move_rover, and these two are able to execute with the updates instance variable @current_rover_instruction and @current_move_instruction, instead of passing it directly.

4. I create a instance variable final_list_rover to keep track of the ouput, and it is being printed at the end


// start over and use TDD approach:
I wrote all the tests cases before starting TDD, follow them as I write.
TDD with class plateau and rover is very straightforward since each instance method is indenpendent, but it got tricky with testing create_rover, move_rover, and read_instruction. Since read_instruction create the instance variable @current_rover_instruction and @current_move_instruction that create_rover and move_rover takes, and in the test i cannot update the instance variable directly, so that I cannot test them separately. So I started testing with read_instruction first, and write a very basic implementation of create_rover and move_rover, just to test their relationship. then when I test create_rover and move_rover, i called read_instruction to help me update instance variable.




