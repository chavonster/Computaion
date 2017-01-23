function [ choice ] = Chicken_00000001( history )
% Returns choice of 0 or 1
% 0 - Chicken
% 1 - Dare
% history is a vector of 2xN previous moves:
% the upper row is the previous moves of your own algorithm,
% and the lower row is the previous moves of your opponent.
% Note that history may be empty!

if isempty(history)
    choice = 1;
else
    c = randi(2,1);
    choice = history(c,end);
end

end

