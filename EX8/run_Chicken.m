function [ u1, u2 ] = run_Chicken( Chicken_name1, Chicken_name2 )
% Chicken_name1 and Chicken_name2 are names of
% 2 strategies (e.g., 'Chicken_00000001' and
% 'Chicken_00000002') given as strings. This function will run them for
% 1000 turns against each other and will report the payoffs of each one

N = 1000 ;
payoffs = zeros(N,2);

choices1 = [];
choices2 = [];

for i = 1:N
    history1 = [choices1; choices2];
    history2 = [choices2; choices1];
    
    fh1 = str2func(Chicken_name1);
    fh2 = str2func(Chicken_name2);
    
    choices1(i) = fh1(history1);
    choices2(i) = fh2(history2);
    
    payoffs(i,:) = single_trial(choices1(i),choices2(i));
end
u1 = sum(payoffs(:,1))/N;
u2 = sum(payoffs(:,2))/N;

