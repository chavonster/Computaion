% ============== EX8 - Game Theory ===============


%1.Run with the given functions against each other
uVec = zeros(20,2);
deltaU = zeros(20,1);
for i = 1:20
    [u1 u2] = run_Chicken('Chicken_30485493', 'titForTat'); 
    uVec(i,:) = [u1 u2];
    deltaU(i) = abs(uVec(i,1) - uVec(i,2));
end