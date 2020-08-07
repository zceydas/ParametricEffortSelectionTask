function [StartPoint]=NumberScroller(leftkey,rightkey,display,centerX,centerY,stimuluscolor)

Screen('TextSize',display.windowPtr, 30);
DrawFormattedText(display.windowPtr, sprintf('%s\n%s\n%s\n%s\n', ...
    'Please indicate the MINIMUM amount of money you would accept for playing this deck', ...
    'for an extra 30 minutes in addition to your participation today.', ...
    'Use right arrow (->) to increase the amount and left arrow (<-) to decrease it.',...
    'When you are done, press any key to continue.'), 'center', 'center', [255 255 255], [100],[],[],[1.25]);
endcode=41;
k=0;
increment=.1;
maxVal=3.1;
minVal=.1;
StartPoint=1.5;
Time0=GetSecs;
Screen('TextSize',display.windowPtr, 40);
Screen('DrawText', display.windowPtr, [sprintf( '%.2f', StartPoint) '   Euros']', centerX - 85, centerY + 100,   [0 255 0]);
Screen('Flip',display.windowPtr);
WaitSecs(.3);
for k = 1:10000000
    k=k+1;
    Screen('TextSize',display.windowPtr, 30);
DrawFormattedText(display.windowPtr, sprintf('%s\n%s\n%s\n%s\n', ...
    'Please indicate the MINIMUM amount of money you would accept for playing this deck', ...
    'for an extra 30 minutes in addition to your participation today.', ...
    'Use right arrow (->) to increase the amount and left arrow (<-) to decrease it.',...
    'When you are done, press any key to continue.'), 'center', 'center', [255 255 255], [100],[],[],[1.25]);
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
    Screen('TextSize',display.windowPtr, 40);
    if Resp == 1
        StartPoint=StartPoint+increment;
        if StartPoint>maxVal
            StartPoint=maxVal;
        end
        Screen('DrawText', display.windowPtr, [sprintf( '%.2f', StartPoint) '   Euros']', centerX - 85, centerY + 100,   [0 255 0]);
        Screen('Flip',display.windowPtr);
        WaitSecs(.2);
    elseif Resp == 0
        StartPoint=StartPoint-increment;
        if StartPoint<minVal
            StartPoint=minVal;
        end
        Screen('DrawText', display.windowPtr, [sprintf( '%.2f', StartPoint) '   Euros']', centerX - 85, centerY + 100,   [0 255 0]);
        Screen('Flip',display.windowPtr);
        WaitSecs(.2);
    elseif Resp == 9
        Screen('Flip',display.windowPtr);
        break
    end
    
end

end

