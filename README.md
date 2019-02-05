# 8puzzlesolver
Given a 3×3 board with 8 tiles (every tile has one number from 1 to 8) and one empty space. Output the sequence of actions to solve the puzzle, i.e. place the numbers on tiles in acsending order by sliding four adjacent tiles into the empty space.

# Files used in the project:
```
[~] puzzle8_115595972.m 	: The main MATLAB code file
[~] Act.m        		: The function that executes a given action (e.g. up, down, left, right) and returns a new node
[~] available_actions.m		: The function that returns the available actions for a given node
[~] isSolvable.m		: The function that checks if the randomly generated node is solvable
[~] Example_Node_3.mat		: The MATLAB Workspace when the code was tested with node=[4,1,2;0,8,7;6,3,5]
```
# How the code works?
```
1.) A random initial node is created until a solvable node is obtained, i.e. a 8 puzzle is not solvable if the number of inversions is odd.
Alternatively, a previously tested node can be used by setting "Random = 0".
2.) Find all available actions for a given node
3.) If the given node is not the initial node nor belong to the 1st generation of nodes, check for the previous action and eliminate the action that cause a duplicate with the parent node.
4.) Create the sub-nodes for each of the parent nodes and concatenate all the new nodes in 3xn matrix "nodes"
5.) Repeat until the goal node or 100,000 new nodes are achieved
6.) Display the result
```
# How to run the code?
```
1.) Copy all 4 of the .m files in the same directory
2.) Launch MATLAB (2017b or later)
3.) Navigate to the folder where the .m files are stored
4.) Open puzzle8_115595972.m and hit F5 
```
```
% If "Random = 1" then this will create a random initial node since this is a breadth first search method
% usually it takes ~500,000 iterations to find the goal node, which can be a long process 
% (over 2 hours) depending on the difficulty of the randomly generated initial node.
% 
% If "Random = 0" then the initial node is one of the three nodes that were tested before and proven that
% the goal node is obtained within less than 100,000 iterations (takes less than 5 mins):
%
% node=[0,1,3;4,2,5;7,8,6];     %Solved in 26 iterations
% node=[1,8,0;4,3,2;5,7,6];     %Solved in 6,732 iterations
% node=[4,1,2;0,8,7;6,3,5];     %Solved in 38,106 iterations
```
