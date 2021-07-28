function  [Results] = LearningPhaseSequence(Instructions)
global MaxLevel subjectId Session letterperm NoNumbers exclude WaitTime FixDur UntilKey PracticeContextDur TrialDeadline ITI 
global NoTrial 
global rightkey leftkey endcode
global display centerX centerY fixFont textfont
Responses=[];
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % %%%%% Record the subject number %%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        load SeqPref
        letter=letterperm(mod(subjectId,length(letterperm))+1,:);
        if Session == 1
            versionNo=mod(subjectId,4)+1;
        else 
            % based on the first session, cross over the color-magnitude
            % and the side-parity mappings
            if mod(subjectId,4)+1 == 1; versionNo = 4; 
            elseif mod(subjectId,4)+1 == 2;  versionNo = 3;
            elseif mod(subjectId,4)+1 == 3;  versionNo = 2;
            elseif mod(subjectId,4)+1 == 4;  versionNo = 1;
            end
        end
        Results.Subject(subjectId).ID = subjectId;
        Results.Subject(subjectId).Session(Session).Date.Learning = datestr(now);
        Results.Subject(subjectId).Session(Session).Version = versionNo;
        Results.Subject(subjectId).Session(Session).Order = letter;
        save SeqPref Results
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%% Generate the effort task  order %%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        temp = repmat(1:MaxLevel,1,NoTrial); %temp organizes the order of levels
        kind=[repmat(1,1,(NoTrial*MaxLevel)/2) repmat(2,1,(NoTrial*MaxLevel)/2)];
        temp=[temp;kind];
        temp=temp(:,randperm(size(temp,2)));
        temp2=temp(1,:);
        kind=temp(2,:);
        temp2(1,end+1) = 0;
        %%%%%%%%%%%%%%%%%% Instructions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [Results] = InstructionsSequence(Results,versionNo);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        CorAns=999;
        m=0;
        j=0;
        while m < 10000
            j=j+1;
            i=1;
            level = temp2(:,j);
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%% set the symbol icon %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            Screen('TextSize',display.windowPtr, fixFont);
            Screen('DrawText', display.windowPtr, sprintf( '%s', '+' ), centerX - 15, centerY -21,   [255 255 255]); Screen('Flip',display.windowPtr); WaitSecs(ITI+rand);
            ContextOnset = GetSecs; 
            if i == 1
                context = letter{level};
                [img,imgtile]=pickDeckImage({},{},context); 
                Screen(display.windowPtr,'PutImage',img,[centerX - 150, centerY - 200, centerX + 150, centerY + 200]);
                Screen('Flip',display.windowPtr);
                WaitSecs(PracticeContextDur);
                ContextOffset = GetSecs; 
                ContextLatency = ContextOffset - ContextOnset; 
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%% Set Number Order for each difficulty level %%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            [Order,switchnumber] = GenerateOrder(level,NoNumbers);
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%% Randomize the decision type order %%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            [List,Parity,Magnitude,ParityOrder] = GenerateNumbers(j,kind,NoNumbers,Order,exclude,versionNo);
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%% generate the number list %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            [Responses,m] = GenerateTrials(j,level,List,m,switchnumber,NoNumbers,Order,versionNo,display,imgtile,centerX,centerY,UntilKey,Parity,TrialDeadline,endcode,rightkey,leftkey,FixDur,WaitTime,Instructions,Responses);    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            Results.Subject(subjectId).Session(Session).Responses.Learning = Responses.Trial;
            save SeqPref Results
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%% End Screen %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            if temp2(1,j+1)==0
                Screen('TextSize', display.windowPtr, textfont);
                DrawFormattedText(display.windowPtr, sprintf('%s\n%s\n%s\n%s\n', ...
                    'Next, you will move on to the Decision Phase. ', ...
                    'Now, we will take a break.', ...
                    'Press a key to exit screen.'), 'center', 'center', [255 255 255], [100]);
                Screen('Flip',display.windowPtr);
                WaitSecs(WaitTime); KbStrokeWait;
                Screen('CloseAll');
                ListenChar(0);
                ShowCursor;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%%%%%%%%%%%%%%%%%%%% Save Data in excel form %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                Temp=[]; Temp=Results.Subject(subjectId).Session(Session).Responses.Learning;
                Table=table(Temp(:,1),Temp(:,2),Temp(:,3),Temp(:,4),Temp(:,5),Temp(:,6),Temp(:,7), ...
                    Temp(:,8), Temp(:,9), Temp(:,10), Temp(:,11), Temp(:,12), Temp(:,13), Temp(:,14), ...
                    'VariableNames',{'BlockNo','EffortLevel','Accuracy','RT', 'SwitchNumber','TrialType', 'Response', ...
                    'Number', 'CorrectAnswer', 'Order', 'StartTrial', 'Trial', 'TrialStartTime', 'TrialStartSince' })
                writetable(Table,['Learning_Session',num2str(Session),'_' 'subject',num2str(subjectId),'_',date,'.xlsx'])
                break
            end
        end
end