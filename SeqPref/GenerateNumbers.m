function [List,Parity,Magnitude,ParityOrder] = GenerateNumbers(j,kind,NoNumbers,Order,exclude,versionNo)

if versionNo == 1 || versionNo == 3 % even on the right, odd on the left
    
    if kind(:,j) == 1 %in order to randomize the order of the parity/magnitude trials, we make the trial types correspond to 1s and 2s which are assigned randomly
        Parity = 1;
        Magnitude = 2;
        ParityOrder = 1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%% generate the number list %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%% with 50% prob of left - right responses %%%%%%%%%%%%%%%%%
        for run=1:1000
            for no=1:NoNumbers
                List(no) = randsample(setdiff(1:9, exclude), 1); %we want to sample all values from 1 to 9, excluding 5 because in the magnitude judgment trial, we will ask them to classify the number as being lesser or greater than 5
            end
            CorrectSide=zeros(1,length(List));
            for n=1:length(List)
                if Order(n) == 2 % magnitude
                    if (List(n)-5) > 0
                        CorrectSide(n) = 0; % 0 if right, 1 if left
                    else
                        CorrectSide(n) = 1; % 0 if right, 1 if left
                    end
                else % parity
                    CorrectSide(n) = mod(mod(List(n),2)+2,2); % 0 if right, 1 if left
                end
            end
            if mean(CorrectSide) == .5
                break
            end
        end
    else
        Parity = 2;
        Magnitude = 1;
        ParityOrder = 2;
        for run=1:1000
            for no=1:NoNumbers
                List(no) = randsample(setdiff(1:9, exclude), 1); %we want to sample all values from 1 to 9, excluding 5 because in the magnitude judgment trial, we will ask them to classify the number as being lesser or greater than 5
            end
            CorrectSide=zeros(1,length(List));
            for n=1:length(List)
                if Order(n) == 2 % parity
                    CorrectSide(n) = mod(mod(List(n),2)+2,2); % 0 if right, 1 if left
                else
                    if (List(n)-5) > 0 % magnitude
                        CorrectSide(n) = 0; % 0 if right, 1 if left
                    else
                        CorrectSide(n) = 1; % 0 if right, 1 if left
                    end
                end
                
            end
            if mean(CorrectSide) == .5 % left and right responses are of equal prob
                break
            end
        end
    end
    
elseif versionNo == 2 || versionNo == 4 % odd is right, even is left
    if kind(:,j) == 1 %in order to randomize the order of the parity/magnitude trials, we make the trial types correspond to 1s and 2s which are assigned randomly
        Parity = 1;
        Magnitude = 2;
        ParityOrder = 1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%% generate the number list %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%% with 50% prob of left - right responses %%%%%%%%%%%%%%%%%
        for run=1:1000
            for no=1:NoNumbers
                List(no) = randsample(setdiff(1:9, exclude), 1); %we want to sample all values from 1 to 9, excluding 5 because in the magnitude judgment trial, we will ask them to classify the number as being lesser or greater than 5
            end
            CorrectSide=zeros(1,length(List));
            for n=1:length(List)
                if Order(n) == 2 % magnitude
                    if (List(n)-5) > 0
                        CorrectSide(n) = 0; % 0 if right, 1 if left
                    else
                        CorrectSide(n) = 1; % 0 if right, 1 if left
                    end
                else % parity
                    CorrectSide(n) = mod(mod(List(n),2)+1,2); % 0 if right, 1 if left
                end
            end
            if mean(CorrectSide) == .5
                break
            end
        end
    else
        Parity = 2;
        Magnitude = 1;
        ParityOrder = 2;
        for run=1:1000
            for no=1:NoNumbers
                List(no) = randsample(setdiff(1:9, exclude), 1); %we want to sample all values from 1 to 9, excluding 5 because in the magnitude judgment trial, we will ask them to classify the number as being lesser or greater than 5
            end
            CorrectSide=zeros(1,length(List));
            for n=1:length(List)
                if Order(n) == 2 % parity
                    CorrectSide(n) = mod(mod(List(n),2)+1,2); % 0 if right, 1 if left
                else
                    if (List(n)-5) > 0 % magnitude
                        CorrectSide(n) = 0; % 0 if right, 1 if left
                    else
                        CorrectSide(n) = 1; % 0 if right, 1 if left
                    end
                end
                
            end
            if mean(CorrectSide) == .5 % left and right responses are of equal prob
                break
            end
        end
    end
    
    
end

end