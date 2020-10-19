function [Results] = DecisionPhaseSequence(Instructions)
global MaxLevel subjectId Session NoNumbers exclude WaitTime FixDur UntilKey TrialDeadline SelectionDeadline ISI
global rightkey leftkey endcode 
global display centerX centerY windowRect
load SeqPref
Responses=[];
FirstFixation=10.8; % first fixation cross lasts this long
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Subject info %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
beginTime = datestr(now);
Results.Subject(subjectId).Session(Session).Date.DecisionBegin = beginTime;
versionNo=Results.Subject(subjectId).Session(Session).Version;
letter=Results.Subject(subjectId).Session(Session).Order; %the order of deck color-effort mappings
letterlist=letter;
save SeqPref Results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% Setup Screen %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Screen('TextSize', display.windowPtr, 25);
textcolor=[255, 255, 255]; % instruction and fixation cross color
boxAngle = 45; buttonDistance = 850;
[x1,y1] = pol2cart(((90 - boxAngle/2)*pi)/160,buttonDistance);
ymarkerOffset = 20;
pos(1,:) = [centerX-x1,centerY -21];%
pos(2,:) = [centerX+x1,centerY -21];%
answerBoxSize = 40;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Set Parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% create the choice vector based on the optseq outputs
TempTable=[];TempTable=readtable(['outputfiles-00', num2str(mod(subjectId,4)+1), '.txt']); % based on subject number, one of four best optseq2 sequences is selected
DifLevels = [1:MaxLevel];
combs = combntns([DifLevels],2); %here we get the permutation of all possible difficulty level combinations
TempOrder=[]; TempOrder=TempTable.Var2(find(TempTable.Var2>0),:);
Side=[]; % counterbalances the left/right placement of the effort decks
for noP=1:length(unique(TempOrder))
    TempList=[]; TempList=Shuffle(find(TempOrder==noP));
    Side(1,TempList(1:length(TempList)/2))=1;
    Side(1,TempList((length(TempList)/2)+1:end))=2;
end
AllTemp=[];
for t=1:length(TempOrder)
    if Side(1,t)==1
        AllTemp(:,t)=[combs(TempOrder(t),1) combs(TempOrder(t),2)]';
    else
        AllTemp(:,t)=[combs(TempOrder(t),2) combs(TempOrder(t),1)]';
    end
end
AllTemp(:,end+1)=0;
m=0;
j=0;
kind=[];
TempITI=[]; TempITI=TempTable.Var3(find(TempTable.Var2==0),:); % ITI durations that follow each Selection + Execution block
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% Instruction Screen %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DrawFormattedText(display.windowPtr, sprintf('%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s', ...
    'This is the Decision Phase. This phase takes around 20 minutes.', ...
    'In this phase, you will choose between the games you played', ...
    'in the Learning phase.', ...
    '(Press a key to continue)'), 'center', 'center', textcolor, [100],[],[],[1.5]);
Screen('Flip',display.windowPtr); WaitSecs(UntilKey);
KbStrokeWait;
DrawFormattedText(display.windowPtr, sprintf('%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s', ...
    'For each decision, there will be two deck of cards ', ...
    'for you to choose between.',...
    'MAKE EACH DECISION CAREFULLY, because after each choice', ...
    'you will play the game selected from the deck of your choice', ...
    '(Press a key to continue)'), 'center', 'center', textcolor, [100],[],[],[1.5]);
Screen('Flip',display.windowPtr); WaitSecs(UntilKey);
KbStrokeWait;
DrawFormattedText(display.windowPtr, sprintf('%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s', ...
    'Study time is the same and will not change based on your',...
    'choices.', ...
    'Always choose the deck you prefer to play from. ', ...
    '(Press a key to continue)'), 'center', 'center', textcolor, [100],[],[],[1.5]);
Screen('Flip',display.windowPtr); WaitSecs(UntilKey);
KbStrokeWait;
DrawFormattedText(display.windowPtr, sprintf('%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s', ...
    'On each trial, you will see one card on the left', ...
    'and one on the right side of the screen.', ...
    'To make your choice, use LEFT or RIGHT ARROW keys.', ...
    'Make your choices as quickly and carefully as possible.', ...
    '(Press a key to continue)'), 'center', 'center', textcolor, [100],[],[],[1.5]);
Screen('Flip',display.windowPtr); WaitSecs(UntilKey);
KbStrokeWait;
DrawFormattedText(display.windowPtr, sprintf('%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s', ...
    'Now press a key to start the experiment.'), 'center', 'center',textcolor, [100],[],[],[1.5]);
Screen('Flip',display.windowPtr); WaitSecs(UntilKey);
KbStrokeWait;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% fMRI START %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Add Pulse Trigger below this line at the Function Start %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
FunctionStartTime=GetSecs; % this is the time point I assume fMRI is starting recording
Screen('TextSize',display.windowPtr, 40);
Screen('DrawText', display.windowPtr, sprintf( '%s', '+' ), centerX - 15, centerY -21,   textcolor);
Screen('Flip',display.windowPtr); WaitSecs(FirstFixation); % this ITI is retrieved from optseq2 optimized list


while m < 10000
    j=j+1;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%% generated Level and reward lists are USED below %%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    take = 99 ; level = 999; RT = 999;
    while take == 99
        level1 = AllTemp(1,j);
        level2 = AllTemp(2,j);
        IDletter1 = letterlist{level1};
        IDletter2 = letterlist{level2};
       
        [img,imgtile,imgfix,imgfixtile]=pickDeckImage(IDletter1,IDletter2);
        
        Screen('TextSize',display.windowPtr, 40);
        Screen('DrawText', display.windowPtr, sprintf( '%s', '+' ), centerX - 15, centerY -21,   textcolor);
        Screen(display.windowPtr,'PutImage',img,[pos(1,1) - 2*answerBoxSize, pos(1,2)- 3*answerBoxSize, pos(1,1) + 2*answerBoxSize, pos(1,2)+ 3*answerBoxSize])
        Screen(display.windowPtr,'PutImage',imgfix,[pos(2,1) - 2*answerBoxSize, pos(2,2)- 3*answerBoxSize, pos(2,1) + 2*answerBoxSize, pos(2,2)+ 3*answerBoxSize])
        
        Screen('Flip',display.windowPtr);
        OfferStart=GetSecs; 
        WaitSecs(UntilKey);
        while KbCheck;
        end;
        while 1
            [keyIsDown,TimeStamp,keyCode] = KbCheck;
            if GetSecs - OfferStart >= SelectionDeadline  %If the duration of the respond exceeded the deadline, then break the while loop
                break
            end
            if keyIsDown
                if (~keyCode(endcode))
                    if (keyCode(leftkey)); take=1; level = level1; imgtile = imgtile; end
                    if (keyCode(rightkey)); take=0; level = level2; imgtile = imgfixtile; end
                    break;
                else
                    Screen('TextSize', display.windowPtr, 25);
                    DrawFormattedText(display.windowPtr, sprintf('%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s', ...
                        'Press ESC to quit the game or press any key to continue.'), 'center', 'center',textcolor, [100],[],[],[1.25]);
                    Screen('Flip',display.windowPtr);
                    WaitSecs(UntilKey)
                    while KbCheck;
                    end;
                    while 1
                        [keyIsDown,TimeStamp,keyCode] = KbCheck;
                        if keyIsDown
                            if (keyCode(endcode))
                                save SeqPref Results
                                Screen('TextSize', display.windowPtr, 25);
                                DrawFormattedText(display.windowPtr, 'Study is over. Thanks for your participation! ', 'center', 'center', [255 255 255], [100]);
                                Screen('Flip',display.windowPtr);
                                WaitSecs(WaitTime);
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
        ResponseMade=GetSecs; RT=ResponseMade-OfferStart;
        if (keyCode(leftkey));
            Screen(display.windowPtr,'PutImage',img,[pos(1,1) - 2*answerBoxSize, pos(1,2)- 3*answerBoxSize, pos(1,1) + 2*answerBoxSize, pos(1,2)+ 3*answerBoxSize])
            Screen('Flip',display.windowPtr);
            WaitSecs(ISI);
        elseif (keyCode(rightkey));
            Screen(display.windowPtr,'PutImage',imgfix,[pos(2,1) - 2*answerBoxSize, pos(2,2)- 3*answerBoxSize, pos(2,1) + 2*answerBoxSize, pos(2,2)+ 3*answerBoxSize])
            Screen('Flip',display.windowPtr);
            WaitSecs(ISI);
        elseif (~keyCode(rightkey) && ~keyCode(leftkey));take=9;
            Screen('Flip',display.windowPtr);
            Screen('TextSize', display.windowPtr, 25);
            DrawFormattedText(display.windowPtr, sprintf('%s\n%s\n%s\n', ...
                'Please make a choice', ...
                'Using right ( > ) and left ( < ) keys.'), 'center', 'center', textcolor, [100]);
            Screen('Flip',display.windowPtr);
            WaitSecs(ISI);
        end
    end
    % based on previous selection, change the order of magnitude/parity
    % questions - to keep this counterbalanced
    
    if j == 1
        kind(1,j) = 1;
    else
        Temp=[]; Temp=Responses.Test((Responses.Test(1:j-1,4)==level),7);
        if ~isempty(Temp) && Temp(end,1) == 1
            kind(1,j) = 2;
        elseif ~isempty(Temp) && Temp(end,1) == 2
            kind(1,j) = 1;
        elseif isempty(Temp)
            kind(1,j) = 1;
        end
    end
    
    Responses.Test(j,1) = j; % block number
    Responses.Test(j,2) = level1 ; %choice on left
    Responses.Test(j,3) = level2 ; %choice on right
    Responses.Test(j,4) = level; %selected effort level
    Responses.Test(j,5) = take; %used key (left or right)
    Responses.Test(j,6) = RT; %decision response time
    Responses.Test(j,7) = kind(1,j); % magnitude or parity kind info
    Responses.Test(j,8) = OfferStart; %beginning of decision epoch in computer time
    Responses.Test(j,9) = OfferStart-FunctionStartTime; %beginning of decision epoch since the start of the function
    Results.Subject(subjectId).Session(Session).Responses.DecisionPhase.Selection = Responses.Test;
    
    if take < 9
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%% Set the Order for each difficulty level %%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [Order,switchnumber] = GenerateOrder(level,NoNumbers);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%% Randomize the decision type order %%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [List,Parity,Magnitude,ParityOrder] = GenerateNumbers(j,kind,NoNumbers,Order,exclude,versionNo);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%% generate the number list %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [Responses,m,ExecutionStartTime] = GenerateTrials(j,level,List,m,switchnumber,NoNumbers,Order,versionNo,display,imgtile,centerX,centerY,UntilKey,Parity,TrialDeadline,endcode,rightkey,leftkey,FixDur,WaitTime,Instructions,Responses);    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        ExecutionEndTime=[];ExecutionEndTime=GetSecs;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        Results.Subject(subjectId).Session(Session).Responses.DecisionPhase.Execution = Responses.Trial;
        Responses.Test(j,10) = ExecutionStartTime-FunctionStartTime; %beginning of exeuction epoch since the start of the function
        Responses.Test(j,11) = ExecutionEndTime-FunctionStartTime; %beginning of exeuction epoch since the start of the function
        Results.Subject(subjectId).Session(Session).Responses.DecisionPhase.Selection = Responses.Test;
    elseif take == 9
        % Results.Subject(subjectId).Responses.DecisionPhase.Execution(end+1)=999;
        AllTemp=[AllTemp(:,1:end-1) AllTemp(:,j) AllTemp(:,end)]; % add the unresponded pair to the end
        TempITI=[TempITI(1:end,1); TempITI(j,1)]; % do the same for ITI list
    end
    save SeqPref Results
    
    Screen('TextSize',display.windowPtr, 40);
    Screen('DrawText', display.windowPtr, sprintf( '%s', '+' ), centerX - 15, centerY -21,   textcolor);
    Screen('Flip',display.windowPtr); WaitSecs(TempITI(j)); % this ITI is retrieved from optseq2 optimized list
    if AllTemp(1,j+1)==0
        break
    end
end

Screen('Flip',display.windowPtr);
EndTime = datestr(now);
Results.Subject(subjectId).Session(Session).Date.DecisionEnd = EndTime;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%% Save Data in excel form %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Temp=[]; Table=[]; Temp=Results.Subject(subjectId).Session(Session).Responses.DecisionPhase.Selection;
Table=table(Temp(:,1),Temp(:,2),Temp(:,3),Temp(:,4),Temp(:,5),Temp(:,6),Temp(:,7), ...
    Temp(:,8), Temp(:,9), Temp(:,10), Temp(:,11), ...
    'VariableNames',{'BlockNo','LeftSide_Effort','RightSide_Effort','ChosenLevel', 'ChosenSide','RT', ...
    'MagParKind', 'OfferStartTime', ...
    'OfferStartTimeSince', 'ExecutionBeginTime', 'ExecutionEndTime' })
writetable(Table,['Decision_Selection_Session',num2str(Session),'_' 'subject',num2str(subjectId),'_',date,'.xlsx'])

Temp=[]; Table=[]; Temp=Results.Subject(subjectId).Session(Session).Responses.DecisionPhase.Execution;
Table=table(Temp(:,1),Temp(:,2),Temp(:,3),Temp(:,4),Temp(:,5),Temp(:,6),Temp(:,7), ...
    Temp(:,8), Temp(:,9), Temp(:,10), Temp(:,11), Temp(:,12), Temp(:,13), Temp(:,14), ...
    'VariableNames',{'BlockNo','EffortLevel','Accuracy','RT', 'SwitchNumber','TrialType', 'Response', ...
    'Number', 'CorrectAnswer', 'Order', 'StartTrial', 'Trial', 'TrialStartTime', 'TrialStartSince' })
writetable(Table,['Decision_Execution_Session',num2str(Session),'_' 'subject',num2str(subjectId),'_',date,'.xlsx'])


save SeqPref Results
Screen('TextSize', display.windowPtr, 25);
DrawFormattedText(display.windowPtr, 'Study is over. Thanks for your participation! ', 'center', 'center', [255 255 255], [100]);
Screen('Flip',display.windowPtr);
WaitSecs(WaitTime);
KbStrokeWait;
Screen('CloseAll');
ListenChar(0);
ShowCursor;

end
