function [CorAns] = DetermineAccuracy(Trial, Order,Number,Parity,versionNo)
if versionNo == 1 || versionNo == 3 % odd on the left, even on the right
    if Order(Trial) == Parity
        if mod(sum(Number),2)==0
            CorAns = 1; %the sum of List array is EVEN
        else
            CorAns = 0; %the sum of List array is ODD
        end
    else
        if Number > 5
            CorAns = 1; %the sum of List array is GREATER than 5
        else
            CorAns = 0; %the sum of List array is SMALLER than 5
        end
    end
elseif versionNo == 2 || versionNo == 4 % odd on the right, even on the left
    if Order(Trial) == Parity
        if mod(sum(Number),2)==0
            CorAns = 0; %the sum of List array is ODD
        else
            CorAns = 1; %the sum of List array is EVEN
        end
    else
        if Number > 5
            CorAns = 1; %the sum of List array is GREATER than 5
        else
            CorAns = 0; %the sum of List array is SMALLER than 5
        end
    end
end
end