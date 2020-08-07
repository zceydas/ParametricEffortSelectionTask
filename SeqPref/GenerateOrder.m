function [Order,switchnumber] = GenerateOrder(level,NoNumbers)

      PossibleSwitches = [1 2 3 4 5 6 7];
        Order=[];
    if level == 1
        switchnumber=1;
        PossibleSwitches = Shuffle(PossibleSwitches);
        Level1Switches = sort(PossibleSwitches(1:switchnumber));
        Order = [ones(1,Level1Switches(1)) ones(1,NoNumbers-Level1Switches(1))+1];
    elseif level == 2
        switchnumber=3;
        PossibleSwitches = Shuffle(PossibleSwitches);
        Level2Switches = sort(PossibleSwitches(1:switchnumber));
        Order = [ones(1,Level2Switches(1)) ones(1,(Level2Switches(2)-Level2Switches(1)))+1 ones(1,(Level2Switches(3)-Level2Switches(2))) ones(1,(NoNumbers-Level2Switches(3)))+1];
    elseif level == 3
        switchnumber=5;
        PossibleSwitches = Shuffle(PossibleSwitches);
        Level3Switches = sort(PossibleSwitches(1:switchnumber));
        Order =  [ones(1,Level3Switches(1)) ones(1,(Level3Switches(2)-Level3Switches(1)))+1 ones(1,(Level3Switches(3)-Level3Switches(2))) ones(1,(Level3Switches(4)-Level3Switches(3)))+1 ones(1,(Level3Switches(5)-Level3Switches(4))) ones(1,(NoNumbers-Level3Switches(5)))+1 ];
    elseif level == 4 % 
        switchnumber=7;
        PossibleSwitches = Shuffle(PossibleSwitches);
        Level4Switches = sort(PossibleSwitches(1:switchnumber));
        Order = [ones(1,Level4Switches(1)) ones(1,(Level4Switches(2)-Level4Switches(1)))+1 ones(1,(Level4Switches(3)-Level4Switches(2))) ones(1,(Level4Switches(4)-Level4Switches(3)))+1 ones(1,(Level4Switches(5)-Level4Switches(4))) ones(1,(Level4Switches(6)-Level4Switches(5)))+1 ones(1,(Level4Switches(7)-Level4Switches(6))) ones(1,(NoNumbers-Level4Switches(7)))+1 ];
    end

end