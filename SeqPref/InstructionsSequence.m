function [Results] = InstructionsSequence(Results,versionNo)
global subjectId Session NoNumbers exclude WaitTime FixDur UntilKey TrialDeadline
global rightkey leftkey endcode
global display centerX centerY textfont
xcor=500; ycor=300;
Screen('TextSize',display.windowPtr, textfont);

DrawFormattedText(display.windowPtr, sprintf('%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s', ...
    'This experiment has Learning and Decision phases.', ...
    'We will explain each phase separately. ', ...
    'The entire experiment lasts about 40min.', ...
    'You can pause the game at any time by pressing ESCAPE.', ...
    'To walk through the instructions, press any key.'), 'center', 'center', [255 255 255], [100],[],[],[1.5]);
Screen('Flip',display.windowPtr);
KbStrokeWait;

DrawFormattedText(display.windowPtr, sprintf('%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s', ...
    'Learning PHASE: You will play a card game.', ...
    'In the game, you have two tasks.', ...
    'To decide whether a number is:', ...
    '1) odd or even', ...
    '2) smaller or greater than 5',...
    '(To advance to the next instruction screen, press any key.)'), 'center', 'center', [255 255 255], [100],[],[],[1.5]);
Screen('Flip',display.windowPtr);
KbStrokeWait;


inst=[];

if versionNo==1 %black parity cards, red magnitude cards, even on the right, odd on the left, smaller on the left, greater on the right
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Instructions%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    inst=1; colorName1='BLACK'; colorName2='RED'; arrowside1='GREEN BUTTON'; arrowside2='YELLOW BUTTON';
    
    [display]=InstructionLines(colorName1,colorName2,arrowside1,arrowside2,inst,display);
    
    Screen('Flip',display.windowPtr);
    KbStrokeWait;
    
    [img] = imread('BlackCard_EvenRight_OddLeft.png');
    Screen(display.windowPtr,'PutImage',img,[centerX - xcor, centerY - ycor, centerX + xcor, centerY + ycor]);
    Screen('Flip',display.windowPtr);
    WaitSecs(UntilKey);
    
    KbStrokeWait;
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%% Exemplar parity judgment %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    DeckName=['Spade' num2str(3)];
    [img] = imread(DeckName,'png');
    Screen(display.windowPtr,'PutImage',img,[centerX - 150, centerY - 200, centerX + 150, centerY + 200]);
    Screen('Flip',display.windowPtr);
    WaitSecs(UntilKey);
    while KbCheck;
    end;
    while 1
        [keyIsDown,TimeStamp,keyCode] = KbCheck;
        if keyIsDown
            if (~keyCode(endcode))
                if (keyCode(rightkey)); Resp=1;   end
                if (keyCode(leftkey)); Resp=0;  end
                if (~keyCode(rightkey) && ~keyCode(leftkey));Resp=9;end
                break;
            end
            while KbCheck;end; % wait until key is released.
        end
    end
    if Resp == 9
        Correct = 0;
        DrawFormattedText(display.windowPtr, 'You pressed the wrong key! ', 'center', 'center', [255 255 255], [100]);
        Screen('Flip',display.windowPtr);
        KbStrokeWait;
    else
        if Resp == 0
            Correct = 1;
            DrawFormattedText(display.windowPtr, 'Correct!', 'center', 'center', [255 0 255], [100]);
            Screen('Flip',display.windowPtr);
            WaitSecs(WaitTime);
        else
            Correct = 0;
            DrawFormattedText(display.windowPtr, 'Incorrect!', 'center', 'center', [255 255 0], [100]);
            Screen('Flip',display.windowPtr);
            WaitSecs(WaitTime);
        end
    end
    
    inst=2;
    [display]=InstructionLines(colorName1,colorName2,arrowside1,arrowside2,inst,display);
    Screen('Flip',display.windowPtr);
    KbStrokeWait;
    
    [img] = imread('RedCard_Magnitude.png');
    Screen(display.windowPtr,'PutImage',img,[centerX - xcor, centerY - ycor, centerX + xcor, centerY + ycor]);
    Screen('Flip',display.windowPtr);
    WaitSecs(UntilKey);
    KbStrokeWait;
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%% Exemplar magnitude judgment %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    DeckName=['Heart' num2str(3)];
    [img] = imread(DeckName,'png');
    Screen(display.windowPtr,'PutImage',img,[centerX - 150, centerY - 200, centerX + 150, centerY + 200]);
    Screen('Flip',display.windowPtr);
    WaitSecs(UntilKey);
    while KbCheck;
    end;
    while 1
        [keyIsDown,TimeStamp,keyCode] = KbCheck;
        if keyIsDown
            if (~keyCode(endcode))
                if (keyCode(rightkey)); Resp=1;   end
                if (keyCode(leftkey)); Resp=0;  end
                if (~keyCode(rightkey) && ~keyCode(leftkey));Resp=9;end
                break;
            end
            while KbCheck;end; % wait until key is released.
        end
    end
    
    if Resp == 9
        Correct = 0;
        DrawFormattedText(display.windowPtr, 'You pressed the wrong key! ', 'center', 'center', [255 255 255], [100]);
        Screen('Flip',display.windowPtr);
        KbStrokeWait;
    else
        if Resp == 0
            Correct = 1;
            DrawFormattedText(display.windowPtr, 'Correct!',  'center', 'center', [255 0 255], [100]);
            Screen('Flip',display.windowPtr);
            WaitSecs(WaitTime);
        else
            Correct = 0;
            DrawFormattedText(display.windowPtr, 'Incorrect!', 'center', 'center', [255 255 0], [100]);
            Screen('Flip',display.windowPtr);
            WaitSecs(WaitTime);
        end
    end
    
    inst=3;
    [display]=InstructionLines(colorName1,colorName2,arrowside1,arrowside2,inst,display);
    
    Screen('Flip',display.windowPtr);
    KbStrokeWait;
    
    [img] = imread('BlackCard_EvenRight_OddLeft.png');
    Screen(display.windowPtr,'PutImage',img,[centerX - xcor, centerY - ycor, centerX + xcor, centerY + ycor]);
    Screen('Flip',display.windowPtr);
    WaitSecs(UntilKey);
    KbStrokeWait;
    
    [img] = imread('RedCard_Magnitude.png');
    Screen(display.windowPtr,'PutImage',img,[centerX - xcor, centerY - ycor, centerX + xcor, centerY + ycor]);
    Screen('Flip',display.windowPtr);
    WaitSecs(UntilKey);
    KbStrokeWait;
    
    
    
elseif versionNo == 2 % parity black cards, magnitude red cards, even on the left, odd on the right, smaller on the left, greater on the right
    
    
    inst=1; colorName1='BLACK'; colorName2='RED'; arrowside2='GREEN BUTTON'; arrowside1='YELLOW BUTTON';
    
    [display]=InstructionLines(colorName1,colorName2,arrowside1,arrowside2,inst,display);
    
    Screen('Flip',display.windowPtr);
    KbStrokeWait;
    
    [img] = imread('BlackCard_EvenLeft_OddRight.png');
    Screen(display.windowPtr,'PutImage',img,[centerX - xcor, centerY - ycor, centerX + xcor, centerY + ycor]);
    Screen('Flip',display.windowPtr);
    WaitSecs(UntilKey);
    KbStrokeWait;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%% Exemplar parity judgment %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    DeckName=['Spade' num2str(3)];
    [img] = imread(DeckName,'png');
    Screen(display.windowPtr,'PutImage',img,[centerX - 150, centerY - 200, centerX + 150, centerY + 200]);
    Screen('Flip',display.windowPtr);
    WaitSecs(UntilKey);
    while KbCheck;
    end;
    while 1
        [keyIsDown,TimeStamp,keyCode] = KbCheck;
        if keyIsDown
            if (~keyCode(endcode))
                if (keyCode(rightkey)); Resp=0;   end
                if (keyCode(leftkey)); Resp=1;  end
                if (~keyCode(rightkey) && ~keyCode(leftkey));Resp=9;end
                break;
            end
            while KbCheck;end; % wait until key is released.
        end
    end
    if Resp == 9
        Correct = 0;
        DrawFormattedText(display.windowPtr, 'You pressed the wrong key! ', 'center', 'center', [255 255 255], [100]);
        Screen('Flip',display.windowPtr);
        KbStrokeWait;
    else
        if Resp == 0
            Correct = 1;
            DrawFormattedText(display.windowPtr, 'Correct!', 'center', 'center', [255 0 255], [100]);
            Screen('Flip',display.windowPtr);
            WaitSecs(WaitTime);
        else
            Correct = 0;
            DrawFormattedText(display.windowPtr, 'Incorrect!', 'center', 'center', [255 255 0], [100]);
            Screen('Flip',display.windowPtr);
            WaitSecs(WaitTime);
        end
    end
    inst=2;
    [display]=InstructionLines(colorName1,colorName2,arrowside1,arrowside2,inst,display);
    Screen('Flip',display.windowPtr);
    KbStrokeWait;
    
    [img] = imread('RedCard_Magnitude.png');
    Screen(display.windowPtr,'PutImage',img,[centerX - xcor, centerY - ycor, centerX + xcor, centerY + ycor]);
    Screen('Flip',display.windowPtr);
    WaitSecs(UntilKey);
    KbStrokeWait;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%% Exemplar magnitude judgment %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    DeckName=['Heart' num2str(3)];
    [img] = imread(DeckName,'png');
    Screen(display.windowPtr,'PutImage',img,[centerX - 150, centerY - 200, centerX + 150, centerY + 200]);
    Screen('Flip',display.windowPtr);
    WaitSecs(UntilKey);
    while KbCheck;
    end;
    while 1
        [keyIsDown,TimeStamp,keyCode] = KbCheck;
        if keyIsDown
            if (~keyCode(endcode))
                if (keyCode(rightkey)); Resp=1;   end
                if (keyCode(leftkey)); Resp=0;  end
                if (~keyCode(rightkey) && ~keyCode(leftkey));Resp=9;end
                break;
            end
            while KbCheck;end; % wait until key is released.
        end
    end
    
    if Resp == 9
        Correct = 0;
        DrawFormattedText(display.windowPtr, 'You pressed the wrong key! ', 'center', 'center', [255 255 255], [100]);
        Screen('Flip',display.windowPtr);
        KbStrokeWait;
    else
        if Resp == 0
            Correct = 1;
            DrawFormattedText(display.windowPtr, 'Correct!',  'center', 'center', [255 0 255], [100]);
            Screen('Flip',display.windowPtr);
            WaitSecs(WaitTime);
        else
            Correct = 0;
            DrawFormattedText(display.windowPtr, 'Incorrect!', 'center', 'center', [255 255 0], [100]);
            Screen('Flip',display.windowPtr);
            WaitSecs(WaitTime);
        end
    end
    
    inst=3;
    [display]=InstructionLines(colorName1,colorName2,arrowside1,arrowside2,inst,display);
    Screen('Flip',display.windowPtr);
    KbStrokeWait;
    
    [img] = imread('BlackCard_EvenLeft_OddRight.png');
    Screen(display.windowPtr,'PutImage',img,[centerX - xcor, centerY - ycor, centerX + xcor, centerY + ycor]);
    Screen('Flip',display.windowPtr);
    WaitSecs(UntilKey);
    KbStrokeWait;
    
    [img] = imread('RedCard_Magnitude.png');
    Screen(display.windowPtr,'PutImage',img,[centerX - xcor, centerY - ycor, centerX + xcor, centerY + ycor]);
    Screen('Flip',display.windowPtr);
    WaitSecs(UntilKey);
    KbStrokeWait;
    
    
    
    
    
elseif versionNo == 3 % parity red cards, black magnitude cards, even on the right, odd on the left, smaller on the left, greater on the right
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Instructions%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    inst=1; colorName2='BLACK'; colorName1='RED'; arrowside1='GREEN BUTTON'; arrowside2='YELLOW BUTTON';
    
    [display]=InstructionLines(colorName1,colorName2,arrowside1,arrowside2,inst,display);
    Screen('Flip',display.windowPtr);
    KbStrokeWait;
    
    [img] = imread('RedCard_EvenRight_OddLeft.png');
    Screen(display.windowPtr,'PutImage',img,[centerX - xcor, centerY - ycor, centerX + xcor, centerY + ycor]);
    Screen('Flip',display.windowPtr);
    WaitSecs(UntilKey);
    KbStrokeWait;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%% Exemplar parity judgment %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    DeckName=['Heart' num2str(3)];
    [img] = imread(DeckName,'png');
    Screen(display.windowPtr,'PutImage',img,[centerX - 150, centerY - 200, centerX + 150, centerY + 200]);
    Screen('Flip',display.windowPtr);
    WaitSecs(UntilKey);
    while KbCheck;
    end;
    while 1
        [keyIsDown,TimeStamp,keyCode] = KbCheck;
        if keyIsDown
            if (~keyCode(endcode))
                if (keyCode(rightkey)); Resp=1;   end
                if (keyCode(leftkey)); Resp=0;  end
                if (~keyCode(rightkey) && ~keyCode(leftkey));Resp=9;end
                break;
            end
            while KbCheck;end; % wait until key is released.
        end
    end
    if Resp == 9
        Correct = 0;
        DrawFormattedText(display.windowPtr, 'You pressed the wrong key! ', 'center', 'center', [255 255 255], [100]);
        Screen('Flip',display.windowPtr);
        KbStrokeWait;
    else
        if Resp == 0
            Correct = 1;
            DrawFormattedText(display.windowPtr, 'Correct!', 'center', 'center', [255 0 255], [100]);
            Screen('Flip',display.windowPtr);
            WaitSecs(WaitTime);
        else
            Correct = 0;
            DrawFormattedText(display.windowPtr, 'Incorrect!', 'center', 'center', [255 255 0], [100]);
            Screen('Flip',display.windowPtr);
            WaitSecs(WaitTime);
        end
    end
    
    inst=2;
    [display]=InstructionLines(colorName1,colorName2,arrowside1,arrowside2,inst,display);
    Screen('Flip',display.windowPtr);
    KbStrokeWait;
    
    [img] = imread('BlackCard_Magnitude.png');
    Screen(display.windowPtr,'PutImage',img,[centerX - xcor, centerY - ycor, centerX + xcor, centerY + ycor]);
    Screen('Flip',display.windowPtr);
    WaitSecs(UntilKey);
    KbStrokeWait;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%% Exemplar magnitude judgment %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    DeckName=['Spade' num2str(3)];
    [img] = imread(DeckName,'png');
    Screen(display.windowPtr,'PutImage',img,[centerX - 150, centerY - 200, centerX + 150, centerY + 200]);
    Screen('Flip',display.windowPtr);
    WaitSecs(UntilKey);
    while KbCheck;
    end;
    while 1
        [keyIsDown,TimeStamp,keyCode] = KbCheck;
        if keyIsDown
            if (~keyCode(endcode))
                if (keyCode(rightkey)); Resp=1;   end
                if (keyCode(leftkey)); Resp=0;  end
                if (~keyCode(rightkey) && ~keyCode(leftkey));Resp=9;end
                break;
            end
            while KbCheck;end; % wait until key is released.
        end
    end
    
    if Resp == 9
        Correct = 0;
        DrawFormattedText(display.windowPtr, 'You pressed the wrong key! ', 'center', 'center', [255 255 255], [100]);
        Screen('Flip',display.windowPtr);
        KbStrokeWait;
    else
        if Resp == 0
            Correct = 1;
            DrawFormattedText(display.windowPtr, 'Correct!',  'center', 'center', [255 0 255], [100]);
            Screen('Flip',display.windowPtr);
            WaitSecs(WaitTime);
        else
            Correct = 0;
            DrawFormattedText(display.windowPtr, 'Incorrect!', 'center', 'center', [255 255 0], [100]);
            Screen('Flip',display.windowPtr);
            WaitSecs(WaitTime);
        end
    end
    
    inst=3;
    [display]=InstructionLines(colorName1,colorName2,arrowside1,arrowside2,inst,display);
    Screen('Flip',display.windowPtr);
    KbStrokeWait;
    
    [img] = imread('RedCard_EvenRight_OddLeft.png');
    Screen(display.windowPtr,'PutImage',img,[centerX - xcor, centerY - ycor, centerX + xcor, centerY + ycor]);
    Screen('Flip',display.windowPtr);
    WaitSecs(UntilKey);
    KbStrokeWait;
    
    [img] = imread('BlackCard_Magnitude.png');
    Screen(display.windowPtr,'PutImage',img,[centerX - xcor, centerY - ycor, centerX + xcor, centerY + ycor]);
    Screen('Flip',display.windowPtr);
    WaitSecs(UntilKey);
    KbStrokeWait;
    
    
elseif versionNo == 4 % parity red cards, magnitude black cards, even on the left, odd on the right, smaller on the left, greater on the right
    
    inst=1; colorName2='BLACK'; colorName1='RED'; arrowside2='GREEN BUTTON'; arrowside1='YELLOW BUTTON';
    [display]=InstructionLines(colorName1,colorName2,arrowside1,arrowside2,inst,display);
    
    Screen('Flip',display.windowPtr);
    KbStrokeWait;
    
    [img] = imread('RedCard_EvenLeft_OddRight.png');
    Screen(display.windowPtr,'PutImage',img,[centerX - xcor, centerY - ycor, centerX + xcor, centerY + ycor]);
    Screen('Flip',display.windowPtr);
    WaitSecs(UntilKey);
    KbStrokeWait;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%% Exemplar parity judgment %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    DeckName=['Heart' num2str(3)];
    [img] = imread(DeckName,'png');
    Screen(display.windowPtr,'PutImage',img,[centerX - 150, centerY - 200, centerX + 150, centerY + 200]);
    Screen('Flip',display.windowPtr);
    WaitSecs(UntilKey);
    while KbCheck;
    end;
    while 1
        [keyIsDown,TimeStamp,keyCode] = KbCheck;
        if keyIsDown
            if (~keyCode(endcode))
                if (keyCode(rightkey)); Resp=0;   end
                if (keyCode(leftkey)); Resp=1;  end
                if (~keyCode(rightkey) && ~keyCode(leftkey));Resp=9;end
                break;
            end
            while KbCheck;end; % wait until key is released.
        end
    end
    if Resp == 9
        Correct = 0;
        DrawFormattedText(display.windowPtr, 'You pressed the wrong key! ', 'center', 'center', [255 255 255], [100]);
        Screen('Flip',display.windowPtr);
        KbStrokeWait;
    else
        if Resp == 0
            Correct = 1;
            DrawFormattedText(display.windowPtr, 'Correct!', 'center', 'center', [255 0 255], [100]);
            Screen('Flip',display.windowPtr);
            WaitSecs(WaitTime);
        else
            Correct = 0;
            DrawFormattedText(display.windowPtr, 'Incorrect!', 'center', 'center', [255 255 0], [100]);
            Screen('Flip',display.windowPtr);
            WaitSecs(WaitTime);
        end
    end
    
    inst=2;
    [display]=InstructionLines(colorName1,colorName2,arrowside1,arrowside2,inst,display);
    
    Screen('Flip',display.windowPtr);
    KbStrokeWait;
    
    [img] = imread('BlackCard_Magnitude.png');
    Screen(display.windowPtr,'PutImage',img,[centerX - xcor, centerY - ycor, centerX + xcor, centerY + ycor]);
    Screen('Flip',display.windowPtr);
    WaitSecs(UntilKey);
    KbStrokeWait;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%% Exemplar magnitude judgment %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    DeckName=['Spade' num2str(3)];
    [img] = imread(DeckName,'png');
    Screen(display.windowPtr,'PutImage',img,[centerX - 150, centerY - 200, centerX + 150, centerY + 200]);
    Screen('Flip',display.windowPtr);
    WaitSecs(UntilKey);
    while KbCheck;
    end;
    while 1
        [keyIsDown,TimeStamp,keyCode] = KbCheck;
        if keyIsDown
            if (~keyCode(endcode))
                if (keyCode(rightkey)); Resp=1;   end
                if (keyCode(leftkey)); Resp=0;  end
                if (~keyCode(rightkey) && ~keyCode(leftkey));Resp=9;end
                break;
            end
            while KbCheck;end; % wait until key is released.
        end
    end
    
    if Resp == 9
        Correct = 0;
        DrawFormattedText(display.windowPtr, 'You pressed the wrong key! ', 'center', 'center', [255 255 255], [100]);
        Screen('Flip',display.windowPtr);
        KbStrokeWait;
    else
        if Resp == 0
            Correct = 1;
            DrawFormattedText(display.windowPtr, 'Correct!',  'center', 'center', [255 0 255], [100]);
            Screen('Flip',display.windowPtr);
            WaitSecs(WaitTime);
        else
            Correct = 0;
            DrawFormattedText(display.windowPtr, 'Incorrect!', 'center', 'center', [255 255 0], [100]);
            Screen('Flip',display.windowPtr);
            WaitSecs(WaitTime);
        end
    end
    inst=3;
    [display]=InstructionLines(colorName1,colorName2,arrowside1,arrowside2,inst,display);
    
    Screen('Flip',display.windowPtr);
    KbStrokeWait;
    
    [img] = imread('RedCard_EvenLeft_OddRight.png');
    Screen(display.windowPtr,'PutImage',img,[centerX - xcor, centerY - ycor, centerX + xcor, centerY + ycor]);
    Screen('Flip',display.windowPtr);
    WaitSecs(UntilKey);
    KbStrokeWait;
    
    [img] = imread('BlackCard_Magnitude.png');
    Screen(display.windowPtr,'PutImage',img,[centerX - xcor, centerY - ycor, centerX + xcor, centerY + ycor]);
    Screen('Flip',display.windowPtr);
    WaitSecs(UntilKey);
    KbStrokeWait;
    
    
end

DrawFormattedText(display.windowPtr, sprintf('%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s', ...
    'Now lets do a full practice ', ...
    'and make sure we understand the rules!',...
    'Remember to be as fast and as accurate as possible! ', ...
    '(Press a key to start practicing)'), 'center', 'center', [255 255 255], [100],[],[],[1.25]);
Screen('Flip',display.windowPtr);
KbStrokeWait;
Responses=[];
j=1; kind=[repmat(1,1,50) repmat(2,1,50)]; kind=Shuffle(kind);
m = 0; level = 999; Instructions = 1;
[imgtile] = imread('PracticeTile','png');
acc = 0; learning=0; switchnumber=4;
while learning < 1 % learning happens with 50% switch probability and a predetermined sequence
    Order = [ 1 2 2 2 1 1 2 1]; 
    
    Shuffle(Order);
    [List,Parity,Magnitude,ParityOrder] = GenerateNumbers(j,kind,NoNumbers,Order,exclude,versionNo)
    [Responses,m] = GenerateTrials(j,level,List,m,switchnumber,NoNumbers,Order,versionNo,display,imgtile,centerX,centerY,UntilKey,Parity,TrialDeadline,endcode,rightkey,leftkey,FixDur,WaitTime,Instructions,Responses)
    Results.Subject(subjectId).Session(Session).Responses.Practice = Responses.Trial;
    j=j+1;
    
    Shuffle(Order);
    [List,Parity,Magnitude,ParityOrder] = GenerateNumbers(j,kind,NoNumbers,Order,exclude,versionNo)
    [Responses,m] = GenerateTrials(j,level,List,m,switchnumber,NoNumbers,Order,versionNo,display,imgtile,centerX,centerY,UntilKey,Parity,TrialDeadline,endcode,rightkey,leftkey,FixDur,WaitTime,Instructions,Responses)
    Results.Subject(subjectId).Session(Session).Responses.Practice = Responses.Trial;
    j=j+1;
    
    Shuffle(Order);
    [List,Parity,Magnitude,ParityOrder] = GenerateNumbers(j,kind,NoNumbers,Order,exclude,versionNo)
    [Responses,m] = GenerateTrials(j,level,List,m,switchnumber,NoNumbers,Order,versionNo,display,imgtile,centerX,centerY,UntilKey,Parity,TrialDeadline,endcode,rightkey,leftkey,FixDur,WaitTime,Instructions,Responses)
    Results.Subject(subjectId).Session(Session).Responses.Practice = Responses.Trial;
    j=j+1;
    
    AverageOver=[]; AverageOver=Responses.Trial(end-23:end,3);
    acc = mean(AverageOver((AverageOver<9),:));
    if acc < .90
        learning = 0;
        Screen('TextSize',display.windowPtr, textfont);
        DrawFormattedText(display.windowPtr, sprintf('%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s', ...
            'Do you have any questions?', ...
            'If yes, please ask the experimenter now.', ...
            'If not, lets continue with the practice!', ...
            '(Press a key to continue.)'), 'center', 'center', [255 255 255], [100],[],[],[1.5]);
        Screen('Flip',display.windowPtr); KbStrokeWait;
    else
        Screen('TextSize',display.windowPtr, textfont);
        DrawFormattedText(display.windowPtr, sprintf('%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s', ...
            'Great! You are now done with the practice.', ...
            'Press a key to learn about the experimental instructions!'), 'center', 'center', [255 255 255], [100],[],[],[1.5]);
        Screen('Flip',display.windowPtr); KbStrokeWait; learning = 1;
        break
    end
end

Temp=[]; Temp=Results.Subject(subjectId).Session(Session).Responses.Practice;
Table=table(Temp(:,1),Temp(:,2),Temp(:,3),Temp(:,4),Temp(:,5),Temp(:,6),Temp(:,7), ...
    Temp(:,8), Temp(:,9), Temp(:,10), Temp(:,11), Temp(:,12), Temp(:,13), Temp(:,14), ...
    'VariableNames',{'BlockNo','EffortLevel','Accuracy','RT', 'SwitchNumber','TrialType', 'Response', ...
    'Number', 'CorrectAnswer', 'Order', 'StartTrial', 'Trial', 'TrialStartTime', 'TrialStartSince' })
writetable(Table,['Practice_Session',num2str(Session),'_' 'subject',num2str(subjectId),'_',date,'.xlsx'])


Responses=[];
if mod(subjectId,Session+1) == 1
    [img] = imread('AllCards','png');
else
    [img] = imread('AllCards2','png');
end
Screen('TextSize',display.windowPtr, textfont);
%Screen(display.windowPtr,'PutImage',img,[centerX - 350, centerY - 350, centerX + 350, centerY - 150]);
DrawFormattedText(display.windowPtr, sprintf('%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s', ...
    'First phase is the Learning Phase. In this phase, you will see', ...
    'sequences of games dealt from 4 different decks of cards.', ...
    'Before each question, you will be presented with the deck', ...
    'the upcoming card games are dealt from.', ...
    'The same card deck will be tiled in the background as you', ...
    'play the games as well.', ...
    '(Press a key to start the experiment)'), 'center', 'center', [255 255 255], [100],[],[],[1.5]);
Screen('Flip',display.windowPtr);
KbStrokeWait;



end