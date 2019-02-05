%ENPM661 Project 1 (Spring 2018): Canberk Suat Gurel, UID: 115595972
%8 puzzle problem using breadth first search
clearvars
clc

count=-1;                       %number of new nodes generated
set_actions=[];                 %record of number of actions available
record_actions=[];              %record of actions taken
nodes=[];                       %record of new nodes
NodesInfo=[];                   %record of parent nodes
new_node=zeros(3,3);            %generated new node when a action is taken
goal_node=[1,2,3;4,5,6;7,8,0];  %desired order of elements
all=[0,1,2,3,4,5,6,7,8];        %all of the elements
opposite=[0 8 0 6 0 4 0 2];     %opposite actions
layer=1;
goal=0;                         % 0 if the goal node is not reached and 1 if it is reached
solvable=0;                     % 0 if the random initial node is not solvable and 1 if it is solvable

Random = 0;     % 0 for testing a previously tested node and 1 for creating a random node

%% Create an initial node and make use it is solvable, 0 symbolizes the blank tile.

if (Random == 0)
    % node=[0,1,3;4,2,5;7,8,6];     %Solved in 26 iterations
    % node=[1,8,0;4,3,2;5,7,6];     %Solved in 6,732 iterations
    node=[4,1,2;0,8,7;6,3,5];       %Solved in 38,106 iterations
elseif (Random == 1)
    while(solvable==~1)
        rand_all=randperm(length(all), 9);
        [~,I] = max(rand_all);
        rand_all(1,I)=0;
        node(:,1)=rand_all([1 4 7]);
        node(:,2)=rand_all([2 5 8]);
        node(:,3)=rand_all([3 6 9]);
        solvable=isSolvable(node);
    end
end

disp(node)

while((goal == ~1)&&(count < 1000000))
    %% Find the available actions for a given node (8:up, 2:down, 4:left,  6:right)
    if(count>=1)
        actions=available_actions(nodes([1 2 3],[layer layer+1 layer+2]));  %nodes is a 3xn matrix that stores a record of new nodes
        layer=layer+3;                                                      %layer is used to shift to the next node
    else
        actions = available_actions(node);  %node is the initial node.
    end
    
    [~,j]=size(actions);            %j is the number of available actions
    set_actions=[set_actions,j];    %set_actions is an array that stores a record of all available actions
    
    %% Keep a record of the previos actions
    if(count==length(nodes)/3)
        [~,m]=size(set_actions);
        h=set_actions(2:m);
        [~,m]=size(h);
        r = repelem(record_actions(1:m),h); %r stores the all possible actions starting from the 2nd generation e.g. r=[8,8,8,6,6,6,4,4,4,2,2,2,4,4,6,6 ... , 6,6,6]
    end
    
    %% Eliminate the action(s) that cause repetition
    % Compare the last j elements of r with the currently available actions
    % and eliminate the action that generates a duplicate.
    if(count==length(nodes)/3)
        actions(any(bsxfun(@eq,opposite(actions)',r(end-j+1:end)),2))=[];
        [~,j]=size(actions);    %j is updated according to the new set of actions
    end
    
    %% Create the sub-nodes for each of the parent nodes
    for i=1:j
        action=actions(1,i);
        record_actions=[record_actions,action];
        if(count>j)                                     % When count>j we are in the 2nd generation
            temp=nodes([1 2 3],[layer-3 layer-2 layer-1]);
            new_node=Act(temp,action);
            if(isequal(new_node,goal_node))             % Check if goal is achieved
                goal=1;
            end
            NodeInfo=[count+1,(layer-1)/3];             % Keep a record of parent node
            NodesInfo=vertcat(NodesInfo,NodeInfo);      % NodesInfo = [ Node #, Parent node #]
            nodes=[nodes,new_node];
            
        elseif(count<=j)    %when count<=j we are either in the 1st generation or the initial node
            if(count==j)
                temp=nodes([1 2 3],[layer-3 layer-2 layer-1]);
                NodeInfo=[count+1,(layer-1)/3];         % Keep a record of parent node
                NodesInfo=vertcat(NodesInfo,NodeInfo);  % NodesInfo = [ Node #, Parent node #]
                new_node=Act(temp,action);
            else
                new_node=Act(node,action);
            end
            if(isequal(new_node,goal_node)) % Check if goal is achieved
                goal=1;
            end
            nodes=[nodes,new_node];
        end
        count=length(nodes)/3
    end
end

%% Display the result

if(goal==1)
    disp('Goal Reached!')
    if(isequal(nodes([1 2 3],[end-2 end-1 end]),goal_node))
        disp(nodes([1 2 3],[end-2 end-1 end]))
        
        % Trace back the parent nodes
        p = NodesInfo(end,1);
        parents = [p];
        while (~isempty(p))
            p =  NodesInfo(find(NodesInfo(:,1)==p),2);
            parents = [parents,p];
        end
        parents = fliplr(parents);
        
        % Find the sequence of actions that result with goal node
        take_actions = [];
        for i=1:length(parents)
            t_a = record_actions(parents(i));
            take_actions = [take_actions, t_a];
        end
        take_actions
        disp('(8:up, 2:down, 4:left,  6:right)')
    elseif(isequal(nodes([1 2 3],[end-5 end-4 end-3]),goal_node))
        disp(nodes([1 2 3],[end-5 end-4 end-3]))
        % Trace back the parent nodes
        p = NodesInfo(end-1,1);
        parents = [p];
        while (~isempty(p))
            p =  NodesInfo(find(NodesInfo(:,1)==p),2);
            parents = [parents,p];
        end
        parents = fliplr(parents);
        
        % Find the sequence of actions that result with goal node
        take_actions = [];
        for i=1:length(parents)
            t_a = record_actions(parents(i));
            take_actions = [take_actions, t_a];
        end
        take_actions
        disp('(8:up, 2:down, 4:left,  6:right)')
    end
elseif(count == 100000)
    disp('A hundred-thousand new nodes are generated!')
end
