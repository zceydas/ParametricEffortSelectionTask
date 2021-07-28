function [Inv] = EndScreenSeq(subjectId,display,rect,centerX,centerY,leftkey,rightkey)
Inv=999;
stimuluscolor=[255 255 255] % white font
Screen('TextSize', display.windowPtr, 30);

position1=999; position2=999; position3=999;

DrawFormattedText(display.windowPtr, sprintf( '%s', '+' ), 'center', 'center', stimuluscolor, [100]);
Screen('Flip',display.windowPtr); WaitSecs(.5);

if mod(subjectId,2) == 0
    Screen('TextSize',display.windowPtr, 30);
    DrawFormattedText(display.windowPtr, sprintf('%s\n%s\n%s\n%s\n', ...
        'Respond to the following questions by using your mouse', ...
        'based on your agreement with the statements regarding', ...
        'the last deck of cards you played only, move your mouse', ...'
        'and then click to move onto the next question.',...
        'Now, press a key to continue.'), 'center', 'center', stimuluscolor, [100],[],[],[1.25]);
    Screen('Flip',display.windowPtr);WaitSecs(.5); KbStrokeWait;
    DrawFormattedText(display.windowPtr, sprintf( '%s', '+' ), 'center', 'center', stimuluscolor, [100]);
    Screen('Flip',display.windowPtr); WaitSecs(.5);
    
    endPoints = {'Disagree', 'Agree'};
    [position1, RespTime1, answer1] = slideScaleSeq(display.windowPtr, sprintf('I loved playing cards from this deck.'), rect, endPoints);
    WaitSecs(.2);
    endPoints = {'Disagree', 'Agree'};
    [position2, RespTime2, answer2] = slideScaleSeq(display.windowPtr, sprintf('I was bored playing cards from this deck.'), rect, endPoints);
    WaitSecs(.2);
    
    [position3]=NumberScroller(leftkey,rightkey,display,centerX,centerY,stimuluscolor);
    %     endPoints = {'0.1 Euro', '3.1 Euro'};
    %     [position3, RespTime3, answer3] = slideScaleSeq(display.windowPtr, ...
    %         sprintf('%s\n%s\n%s\n%s\n', ...
    %         'What is the minimum amount of money you would accept', ...
    %         'to perform this task for an extra 30 minutes following', ...
    %         'your participation?'), rect, endPoints);
    WaitSecs(.2);
else
    [position3]=NumberScroller(leftkey,rightkey,display,centerX,centerY,stimuluscolor);
    WaitSecs(.2);
    Screen('TextSize',display.windowPtr, 30);
    DrawFormattedText(display.windowPtr, sprintf('%s\n%s\n%s\n%s\n', ...
        'Respond to the following questions by using your mouse', ...
        'based on your agreement with the statements regarding', ...
        'the last deck of cards you played only, move your mouse', ...'
        'and then click to move onto the next question.',...
        'Now, press a key to continue.'), 'center', 'center', stimuluscolor, [100],[],[],[1.25]);
    Screen('Flip',display.windowPtr);WaitSecs(.5); KbStrokeWait;
    
    DrawFormattedText(display.windowPtr, sprintf( '%s', '+' ), 'center', 'center', stimuluscolor, [100]);
    Screen('Flip',display.windowPtr); WaitSecs(.5);
    endPoints = {'Disagree', 'Agree'};
    [position1, RespTime1, answer1] = slideScaleSeq(display.windowPtr, sprintf('I loved playing cards from this deck.'), rect, endPoints);
    WaitSecs(.2);
    endPoints = {'Disagree', 'Agree'};
    [position2, RespTime2, answer2] = slideScaleSeq(display.windowPtr, sprintf('I was bored playing cards from this deck.'), rect, endPoints);
    WaitSecs(.2);
    
end

Inv(1,1)=(position1/2+50)/100;
Inv(1,2)=(position2/2+50)/100;
Inv(1,3)=position3;

end