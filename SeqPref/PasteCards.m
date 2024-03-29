function [TrialType] = PasteCards(Order,Trial,display,imgtile,centerX,centerY,UntilKey,Parity,Number,versionNo)
xcor=500; ycor=300;
if versionNo == 1 || versionNo == 2 % parity black cards, red magnitude cards
    
    if Order(Trial) == Parity
        Screen(display.windowPtr,'PutImage',imgtile,[centerX - xcor, centerY - ycor, centerX + xcor, centerY + ycor]);
        TrialType = 1;
        DeckName=['Spade' num2str(Number)];
        [img] = imread(DeckName,'png');
        Screen(display.windowPtr,'PutImage',img,[centerX - 150, centerY - 200, centerX + 150, centerY + 200]);
        Screen('TextSize',display.windowPtr, 25);
        Screen('Flip',display.windowPtr);
        WaitSecs(UntilKey);
    else
        Screen(display.windowPtr,'PutImage',imgtile,[centerX - xcor, centerY - ycor, centerX + xcor, centerY + ycor]);
        TrialType = 2;
        DeckName=['Heart' num2str(Number)];
        [img] = imread(DeckName,'png');
        Screen(display.windowPtr,'PutImage',img,[centerX - 150, centerY - 200, centerX + 150, centerY + 200]);
        Screen('TextSize',display.windowPtr, 25);
        Screen('Flip',display.windowPtr);
        WaitSecs(UntilKey);
    end
elseif versionNo == 3 || versionNo == 4 % parity red cards, black magnitude cards
    if Order(Trial) == Parity
        Screen(display.windowPtr,'PutImage',imgtile,[centerX - xcor, centerY - ycor, centerX + xcor, centerY + ycor]);
        TrialType = 1;
        DeckName=['Heart' num2str(Number)];
        [img] = imread(DeckName,'png');
        Screen(display.windowPtr,'PutImage',img,[centerX - 150, centerY - 200, centerX + 150, centerY + 200]);
        Screen('TextSize',display.windowPtr, 25);
        Screen('Flip',display.windowPtr);
        WaitSecs(UntilKey);
    else
        Screen(display.windowPtr,'PutImage',imgtile,[centerX - xcor, centerY - ycor, centerX + xcor, centerY + ycor]);
        TrialType = 2;
        DeckName=['Spade' num2str(Number)];
        [img] = imread(DeckName,'png');
        Screen(display.windowPtr,'PutImage',img,[centerX - 150, centerY - 200, centerX + 150, centerY + 200]);
        Screen('TextSize',display.windowPtr, 25);
        Screen('Flip',display.windowPtr);
        WaitSecs(UntilKey);
    end
end
end