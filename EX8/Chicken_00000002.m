function [ choice ] = Chicken_00000002( history )
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
    s = zeros(1,2);
    s(1) = sum(sum(history(2,:)==0));
    s(2) = sum(sum(history(2,:)==1));
    if s(1)==s(2)
        choice = randi(2,1)-1;
    else
        [~ , indChoice] = max(s);
        choice = ~(indChoice-1);
    end
end

end
