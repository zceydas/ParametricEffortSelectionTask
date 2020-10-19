function  [Responses,m,ExecutionStartTime] = GenerateTrials(j,level,List,m,switchnumber,NoNumbers,Order,versionNo,display,imgtile,centerX,centerY,UntilKey,Parity,TrialDeadline,endcode,rightkey,leftkey,FixDur,WaitTime,Instructions,Responses)

Count = 0;
Screen('TextSize',display.windowPtr, 40);
Screen('DrawText', display.windowPtr, sprintf( '%s', '+' ), centerX - 15, centerY -21,   [255 255 255]); Screen('Flip',display.windowPtr); WaitSecs(FixDur);

for Trial = 1 : NoNumbers
    CorAns = 999;
    Exceed = 0;
    Count = Count+1;
    if Trial == 1
        Start = 1;
        ExecutionStartTime=GetSecs;
    end
    TrialStartTime=GetSecs;
    Screen(display.windowPtr,'PutImage',imgtile,[centerX - 550, centerY - 400, centerX + 550, centerY + 400]);
    Number = List(Trial);
    
    Screen('TextSize',display.windowPtr, 40);
    Screen('DrawText', display.windowPtr, sprintf( '%s', '+' ), centerX - 15, centerY -21,   [255 255 255]); Screen('Flip',display.windowPtr); WaitSecs(FixDur);
    
    
    [TrialType] = PasteCards(Order,Trial,display,imgtile,centerX,centerY,UntilKey,Parity,Number,versionNo); % version specific card color selection
    
    RespStart = GetSecs;
    while KbCheck;
    end;
    
    %%%%
    
    while 1
        [keyIsDown,TimeStamp,keyCode] = KbCheck;
        if GetSecs - RespStart >= TrialDeadline  %If the duration of the respond exceeded the deadline, then break the while loop
            Exceed = 1; %then exceed is 1, which makes the response incorrect and then gives the feedback 'REspond faster'
            break
        end
        if keyIsDown
            if (~keyCode(endcode))
                if (keyCode(rightkey)); Resp=1;   end
                if (keyCode(leftkey)); Resp=0;  end
                if (~keyCode(rightkey) && ~keyCode(leftkey));Resp=9;end
                break;
            else
                Screen('TextSize', display.windowPtr, 25);
                DrawFormattedText(display.windowPtr, sprintf('%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s', ...
                    'Press ESC to quit the game or press any key to continue.'), 'center', 'center',[255 255 255], [100],[],[],[1.25]);
                Screen('Flip',display.windowPtr);
                WaitSecs(UntilKey)
                while KbCheck;
                end;
                while 1
                    [keyIsDown,TimeStamp,keyCode] = KbCheck;
                    if keyIsDown
                        if (keyCode(endcode))
                            Screen('TextSize', display.windowPtr, 25);
                            DrawFormattedText(display.windowPtr, 'Study is over. Thanks for your participation! ', 'center', 'center', [255 255 255], [100]);
                            Screen('Flip',display.windowPtr);
                            WaitSecs(2);
                            Screen('CloseAll');
                            ListenChar(0);
                            ShowCursor;
                        elseif (~keyCode(endcode))
                            break;
                        end
                    end
                end
            end
            while KbCheck;end; % wait until key is released.
        end
    end
    Latency = GetSecs - RespStart;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %determine whether the sum of list elements are even or odd or greater/smaller than 5
    %If even, then CorAns is 1, if Odd, then CorAns is 0. If greater CorAns
    %is 1
    
    if Exceed < 1 %if deadline is not passed, then get in this section
        
        [CorAns] = DetermineAccuracy(Trial, Order,Number,Parity,versionNo); % determine accuracy based on script version
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%% give feedback %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Resp is the odd/even response. If right key, then even response, if left
        % key then odd response
      
        Screen(display.windowPtr,'PutImage',imgtile,[centerX - 550, centerY - 400, centerX + 550, centerY + 400]);
        if Resp == 9
            Correct = 0;
            DrawFormattedText(display.windowPtr, 'You pressed the wrong key! ', 'center', 'center', [255 255 255], [100]);
            Screen('Flip',display.windowPtr);
            KbStrokeWait;
        else
            
            if Resp == CorAns
                Correct = 1;
                if Instructions == 1
                DrawFormattedText(display.windowPtr, 'Correct! ', 'center', 'center', [0 255 0], [100]);
                Screen('Flip',display.windowPtr);
                WaitSecs(WaitTime);
                end
            else
                Correct = 0;
                if Instructions == 1
                DrawFormattedText(display.windowPtr, 'Incorrect! ', 'center', 'center', [255 0 0], [100]);
                Screen('Flip',display.windowPtr);
                WaitSecs(WaitTime);
                end
            end
            
        end
    else %if the deadline is passed
        Correct = 0;
        Resp = 9;
        DrawFormattedText(display.windowPtr, 'Please respond faster! ', 'center', 'center', [255 255 255], [100]);
        Screen('Flip',display.windowPtr);
        WaitSecs(WaitTime); 
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%% Record data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % First column is the difficulty level (1 easiest, 6 hardest)
    % Second column is the accuracy column, if 1 correct, if 0 incorrect
    % Third column is RT (starting after the ITI)
    % 4th is the switchnumber, tells how many switches there were
    % in this trial. 5th column is the trial type: if 1 odd/even
    % judgment, if 2, magnitude . The resp
    % is the response. 7th column is the number presented on that
    % trial
    m = m+1;
    Responses.Trial(m,1) = j ;
    Responses.Trial(m,2) = level ;
    Responses.Trial(m,3) = Correct ;
    Responses.Trial(m,4) = Latency ;
    Responses.Trial(m,5) = switchnumber;
    Responses.Trial(m,6) = TrialType;
    Responses.Trial(m,7) = Resp;
    Responses.Trial(m,8) = Number;
    Responses.Trial(m,9) = CorAns;
    Responses.Trial(m,10)=Order(Trial);
    Responses.Trial(m,11)=Start;
    Responses.Trial(m,12)=Trial;
    Responses.Trial(m,13)=TrialStartTime; %Trial Start Time in computer time
    Responses.Trial(m,14)=TrialStartTime-ExecutionStartTime; %Time elapsed since the first trial execution
end
Screen('Flip',display.windowPtr);
end