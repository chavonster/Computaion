function [ choice ] = Chicken_30485493( history )
% Defines a strategy for the chicken or dare game a
% assuming the number of rounds is one thousand
% The key advanatge of this strategy to my taste is that it shifts
% between very different tactics based on a more long term experience

%=== Strategy types ===
%P - peaceful strategy
%T - tit for tat strategy
%D - probing for defect
%A - super aggresive player - always defects

%the current strategy can take the direction of any of the above 

%Set initial strategy to peaceful for first fifty rounds (default behavior)
strategy = 'P';


nPrevRounds = length(history);
whoDefectedFirst = 0;

%After an empiric threshold of 50 rounds we try to assess our strategy
%based on rival's actions. In particular we are intersted in who was
%the first to defect and who managed to surprise the other more with 
% defecting. I.e. defecting when the other cooperates

roundsThreshold = 50;
detactRandomThreshold = 200;
if nPrevRounds > roundsThreshold   
   
    relevantHistory = history(:,nPrevRounds - roundsThreshold +1:nPrevRounds);
    for i = 1:roundsThreshold
        if (relevantHistory(1,i) ~= relevantHistory(2,i))                 
            if (relevantHistory(1,i) == 1)
                whoDefectedFirst = 1; %1 - meaning I defected first
                break; 
            else
                whoDefectedFirst = 2; %Rival defected first           
                break;
            end
        end        
    end
    %Counts who cheated more on the other
    nMyDefections = sum((relevantHistory(1,:) ~= relevantHistory(2,:)) & ...
         (relevantHistory(1,:) == 1)); 
            
     nHisDefections = sum((relevantHistory(1,:) ~= relevantHistory(2,:)) & ...
         (relevantHistory(2,:) == 1)); 
    %Choose strategy accordingly
    if (nHisDefections < 5)
        strategy = 'D';      
    elseif (nHisDefections >= nMyDefections && whoDefectedFirst == 2)        
        strategy = 'T';                            
    elseif (nMyDefections > nHisDefections && whoDefectedFirst == 1)    
        strategy = 'D';
    else
        strategy = 'P';
    end
    
    %Try to determine if player is random - look at his decision's ratio
    %for the entire history and not just last 50 rounds
    if nPrevRounds > detactRandomThreshold && getLongestStrick(history(2,:)) < 10
        rivalDecRatio = sum(history(2,:) == 0) / sum(history(2,:) == 1);
        if abs(rivalDecRatio - 0.5) < 0.05 
            strategy = 'A';
        end
    end
    
end

switch(strategy)
    case 'D'
        randThreshold = 8;
        rivalLast4Moves = history(1,nPrevRounds-3:nPrevRounds);
        randFactor = randi([1,100],1,1); 
        if (sum(rivalLast4Moves == 1) >= 3)
            choice = 1;
        elseif randFactor < randThreshold
            choice = 1;
        else
            choice = 0;
        end                
    case 'T'
        choice = history(2, nPrevRounds);        
    case 'A' 
        choice = 1; 
    %Default behavior is Peaceful
    otherwise
        if (nPrevRounds < 5)
            choice = 0;
        else
            rivalLast5Moves = history(1,nPrevRounds-4:nPrevRounds);
            if (sum(rivalLast5Moves == 1) >= 4)
                choice = 1;
            else
                choice = 0;
            end
        end
        
        
end

%Last three rounds - always defect
if nPrevRounds >= 998
    choice = 1;    
end

%Find the longest strick in rival history 
%for determining random behavior
function maxStrick = getLongestStrick(rivalHistory)
strick = 0;
maxStrick = 0;
for i = 2:length(rivalHistory)
    if (rivalHistory(i-1) == rivalHistory(i))
       strick = strick + 1;
       if strick > maxStrick
           maxStrick = strick;
       end
    else
        strick = 0;
    end
end        





