function [payoff] = single_trial(choice1,choice2)
% Given 2 choices of 1 (dare) or 0 (chicken) returns the payoff for the
% first and second player

if choice1 == 0
    if choice2 == 0        
        payoff = [6,6];
    elseif choice2 == 1
        payoff = [2,7];
    end
elseif choice1 == 1
    if choice2 == 0
        payoff = [7,2];
    elseif choice2 == 1
        payoff = [0,0];
    end
end

end