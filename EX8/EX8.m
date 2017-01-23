%===== EX8 - Game Theory =====

%Define payoff matrices for players
player1_mat = [0 7; 2 6];
player2_mat = [0 2; 7 6];

%Num of rounds
N = 1000;

%Choose strategies for players:
%
%
%
%
randGame = true;
if (randGame)
    randStratGen = randi([1 5], 1, 2);
    strategy1 = randStratGen(1);
    strategy2 = randStratGen(2);     
else
    strategy1 = 0;
    strategy2 = 0;
end

cum_reward_player1 = 0;
cum_reward_player2 = 0;
cur_reward_player1 = -1;
cur_reward_player2 = -1;
history_alloc = ones(2,N).*(-1);
for i = 1:N
    history = history_alloc(:,begin:i);  
    player1_choice = strategyManager(strategy1, history); %call strategy function for players
    player2_choice = strategyManager(strategy2, history);
    %Append decisions to history array
    history(1,i) = player1_choice;
    history(2,i) = player2_choice; 
    
    %Get matching reward by payoff matrices
    if (player1_choice == 1 && player2_choice == 1)
        cur_reward_player1 = player1_mat(1,1);
        cur_reward_player2 = player2_mat(1,1);   
    end
    if (player1_choice == 1 && player2_choice == 0)
        cur_reward_player1 = player1_mat(1,2);
        cur_reward_player2 = player2_mat(1,2);   
    end
    if (player1_choice == 0 && player2_choice == 1)
        cur_reward_player1 = player1_mat(2,1);
        cur_reward_player2 = player2_mat(2,1);   
    end
    if (player1_choice == 0 && player2_choice == 0)
        cur_reward_player1 = player1_mat(2,2);
        cur_reward_player2 = player2_mat(2,2);   
    end        
    
    cum_reward_player1 = cum_reward_player1 + cur_reward_player1;
    cum_reward_player2 = cum_reward_player2 + cur_reward_player2;   
    
end

