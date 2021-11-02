function [Results] = DecisionPhaseSequenceButton(Instructions)
global MaxLevel subjectId Session NoNumbers exclude WaitTime FixDur UntilKey TrialDeadline SelectionDeadline ISI
global display centerX centerY fixFont textfont
handle = CedrusResponseBox('Open','COM2');  open the communication w Cedrus 
escape=3; % assign button box values for escape, left and right responses
leftresp=1;
rightresp=2;
trigger=6; 
TotalRunTime=10; Run=1; BreakTime=20;  % break duration between runs
buttons=[]; answer=[]; keyIsDown=[];
load SeqPref
Responses=[];
FirstFixation=11.2; % first fixation cross lasts this long
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
Screen('TextSize', display.windowPtr, textfont);
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
buttons=[];
DrawFormattedText(display.windowPtr, sprintf('%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s', ...
    'This is the Decision Phase. This phase takes around 20 minutes.', ...
    'In this phase, you will choose between the games you played', ...
    'in the Learning phase.', ...
    '(Press a button to continue)'), 'center', 'center', textcolor, [100],[],[],[1.5]);
Screen('Flip',display.windowPtr); WaitSecs(UntilKey);
buttons=[];while 1;buttons =CedrusResponseBox('GetButtons', handle); if any(buttons); break; end; end % check for button press
DrawFormattedText(display.windowPtr, sprintf('%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s', ...
    'For each decision, there will be two deck of cards ', ...
    'for you to choose between.',...
    'MAKE EACH DECISION CAREFULLY, because after each choice', ...
    'you will play the game selected from the deck of your choice', ...
    '(Press a button to continue)'), 'center', 'center', textcolor, [100],[],[],[1.5]);
Screen('Flip',display.windowPtr); WaitSecs(UntilKey);
buttons=[];while 1;buttons =CedrusResponseBox('GetButtons', handle); if any(buttons); break; end; end % check for button press
DrawFormattedText(display.windowPtr, sprintf('%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s', ...
    'Study time is the same and will not change based on your',...
    'choices.', ...
    'Always choose the deck you prefer to play from. ', ...
    '(Press a button to continue)'), 'center', 'center', textcolor, [100],[],[],[1.5]);
Screen('Flip',display.windowPtr); WaitSecs(UntilKey);
buttons=[];while 1;buttons =CedrusResponseBox('GetButtons', handle); if any(buttons); break; end; end % check for button press
DrawFormattedText(display.windowPtr, sprintf('%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s', ...
    'On each trial, you will see one card on the left', ...
    'and one on the right side of the screen.', ...
    'To make your choice, use LEFT or RIGHT BUTTONS.', ...
    'Make your choices as quickly and carefully as possible.', ...
    '(Press a button to continue)'), 'center', 'center', textcolor, [100],[],[],[1.5]);
Screen('Flip',display.windowPtr); WaitSecs(UntilKey);
buttons=[];while 1;buttons =CedrusResponseBox('GetButtons', handle); if any(buttons); break; end; end % check for button press
DrawFormattedText(display.windowPtr, sprintf('%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s', ...
    'Now please wait for scanner to start the experiment.'), 'center', 'center',textcolor, [100],[],[],[1.5]);
Screen('Flip',display.windowPtr); WaitSecs(UntilKey);
buttons=[];while 1;buttons =CedrusResponseBox('GetButtons', handle); if any(buttons); break; end; end % check for button press

answer=[];
while 1 %waits for trigger from scanner and then moves on to experiment
buttons =CedrusResponseBox('GetButtons', handle); answer=buttons.button; 
if answer==trigger
break;
end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% fMRI START %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Add Pulse Trigger below this line at the Function Start %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
FunctionStartTime=GetSecs; % this is the time point I assume fMRI is starting recording
Screen('TextSize',display.windowPtr, fixFont);
Screen('DrawText', display.windowPtr, sprintf( '%s', '+' ), centerX - 15, centerY -21,   textcolor);
Screen('Flip',display.windowPtr); WaitSecs(FirstFixation); % this ITI is retrieved from optseq2 optimized list
Run=1;

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
        
        Screen('TextSize',display.windowPtr, fixFont);
        Screen('DrawText', display.windowPtr, sprintf( '%s', '+' ), centerX - 15, centerY -21,   textcolor);
        Screen(display.windowPtr,'PutImage',img,[pos(1,1) - 2*answerBoxSize, pos(1,2)- 3*answerBoxSize, pos(1,1) + 2*answerBoxSize, pos(1,2)+ 3*answerBoxSize])
        Screen(display.windowPtr,'PutImage',imgfix,[pos(2,1) - 2*answerBoxSize, pos(2,2)- 3*answerBoxSize, pos(2,1) + 2*answerBoxSize, pos(2,2)+ 3*answerBoxSize])
        Screen('Flip',display.windowPtr);
        OfferStart=GetSecs; 
        WaitSecs(UntilKey);
        answer=[];
        while 1
            buttons =CedrusResponseBox('GetButtons', handle); answer=buttons.button; 
            if GetSecs - OfferStart >= SelectionDeadline  %If the duration of the respond exceeded the deadline, then break the while loop
                break
            end
            if any(buttons) 
                if answer~=escape 
                    if answer==leftresp ; take=1; level = level1; imgtile = imgtile; end
                    if answer==rightresp ; take=0; level = level2; imgtile = imgfixtile; end
                    buttons=CedrusResponseBox('FlushEvents', handle);   
                    break;
                else
                    Screen('TextSize', display.windowPtr, textfont);
                    DrawFormattedText(display.windowPtr, sprintf('%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s', ...
                        'Press button3 to quit the game or press any button to continue.'), 'center', 'center',textcolor, [100],[],[],[1.25]);
                    Screen('Flip',display.windowPtr);
                    WaitSecs(UntilKey)
                    while any(buttons(1,:));buttons=CedrusResponseBox('FlushEvents', handle);answer=[]; end;    
                    while 1
                       buttons =CedrusResponseBox('GetButtons', handle); answer=buttons.button; 
                        if any(buttons)
                            if answer==escape 
                                save SeqPref Results
                                Screen('TextSize', display.windowPtr, textfont);
                                DrawFormattedText(display.windowPtr, 'Study is over. Thanks for your participation! ', 'center', 'center', [255 255 255], [100]);
                                Screen('Flip',display.windowPtr);
                                WaitSecs(WaitTime);
                                Screen('CloseAll');
                                ListenChar(0);
                                ShowCursor;
                            elseif answer~=escape 
                                break;
                            end
                        end
                    end
                end
               answer=[]; while CedrusResponseBox('WaitButtons', handle); answer=buttons.button; end; 
            end
        end
        ResponseMade=GetSecs; RT=ResponseMade-OfferStart;
        if answer==leftresp 
            Screen(display.windowPtr,'PutImage',img,[pos(1,1) - 2*answerBoxSize, pos(1,2)- 3*answerBoxSize, pos(1,1) + 2*answerBoxSize, pos(1,2)+ 3*answerBoxSize])
            Screen('Flip',display.windowPtr);
            WaitSecs(ISI);
        elseif answer==rightresp 
            Screen(display.windowPtr,'PutImage',imgfix,[pos(2,1) - 2*answerBoxSize, pos(2,2)- 3*answerBoxSize, pos(2,1) + 2*answerBoxSize, pos(2,2)+ 3*answerBoxSize])
            Screen('Flip',display.windowPtr);
            WaitSecs(ISI);
        elseif (answer~=leftresp && answer~=rightresp)  ;take=9;
            Screen('Flip',display.windowPtr);
            Screen('TextSize', display.windowPtr, textfont);
            DrawFormattedText(display.windowPtr, sprintf('%s\n%s\n%s\n', ...
                'Please make a choice', ...
                'Using right and left buttons.'), 'center', 'center', textcolor, [100]);
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
    Responses.Test(j,9) = OfferStart-FunctionStartTime; %beginning of decision epoch since the start of the trigger
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
        [Responses,m,ExecutionStartTime] = GenerateTrials_buttonbox(j,level,List,m,switchnumber,NoNumbers,Order,versionNo,display,imgtile,centerX,centerY,UntilKey,Parity,TrialDeadline,escape,rightresp,leftresp,FixDur,WaitTime,Instructions,Responses);    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        ExecutionEndTime=[];ExecutionEndTime=GetSecs;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        Results.Subject(subjectId).Session(Session).Responses.DecisionPhase.Execution = Responses.Trial;
        Responses.Test(j,10) = ExecutionStartTime-FunctionStartTime; %beginning of exeuction epoch since the start of the function
        Responses.Test(j,11) = ExecutionEndTime-FunctionStartTime; %beginning of exeuction epoch since the start of the function
        Responses.Test(j,12)= Run; % keep track of which run it is 
        Results.Subject(subjectId).Session(Session).Responses.DecisionPhase.Selection = Responses.Test;
    elseif take == 9
        Responses.Test(j,10:11)=999;
        % Results.Subject(subjectId).Responses.DecisionPhase.Execution(end+1)=999;
        AllTemp=[AllTemp(:,1:end-1) AllTemp(:,j) AllTemp(:,end)]; % add the unresponded pair to the end
        TempITI=[TempITI(1:end,1); TempITI(j,1)]; % do the same for ITI list
        Responses.Test(j,12)= Run; % keep track of which run it is 
        Results.Subject(subjectId).Session(Session).Responses.DecisionPhase.Selection = Responses.Test;
    end
    save SeqPref Results
    
    Screen('TextSize',display.windowPtr, fixFont);
    Screen('DrawText', display.windowPtr, sprintf( '%s', '+' ), centerX - 15, centerY -21,   textcolor);
    Screen('Flip',display.windowPtr); WaitSecs(TempITI(j)); % this ITI is retrieved from optseq2 optimized list
    if AllTemp(1,j+1)==0
        break
    elseif (GetSecs-FunctionStartTime)/60 >= TotalRunTime
        Screen('TextSize', display.windowPtr, textfont);
        DrawFormattedText(display.windowPtr, 'You can now take a break. Please remember to stay still.', 'center', 'center', [255 255 255], [100]);
        Screen('Flip',display.windowPtr);
        WaitSecs(BreakTime)
        answer=[];
        while 1 %waits for trigger from scanner and then moves on to experiment
            buttons =CedrusResponseBox('GetButtons', handle);  answer=buttons.button; 
            if answer==trigger 
                break;
            end
        end
        FunctionStartTime=GetSecs; % this is the time point I assume fMRI is starting recording
        Screen('TextSize',display.windowPtr, fixFont);
        Screen('DrawText', display.windowPtr, sprintf( '%s', '+' ), centerX - 15, centerY -21,   textcolor);
        Screen('Flip',display.windowPtr); WaitSecs(FirstFixation); % this ITI is retrieved from optseq2 optimized list
        Run=2;
    end
end

Screen('Flip',display.windowPtr);
EndTime = datestr(now);
Results.Subject(subjectId).Session(Session).Date.DecisionEnd = EndTime;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%% Save Data in excel form %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Temp=[]; Table=[]; Temp=Results.Subject(subjectId).Session(Session).Responses.DecisionPhase.Selection;
Table=table(Temp(:,1),Temp(:,2),Temp(:,3),Temp(:,4),Temp(:,5),Temp(:,6),Temp(:,7), ...
    Temp(:,8), Temp(:,9), Temp(:,10), Temp(:,11), Temp(:,12), ...
    'VariableNames',{'BlockNo','LeftSide_Effort','RightSide_Effort','ChosenLevel', 'ChosenSide','RT', ...
    'MagParKind', 'OfferStartTime', ...
    'OfferStartTimeSince', 'ExecutionBeginTime', 'ExecutionEndTime', 'Run' })
writetable(Table,['Decision_Selection_Session',num2str(Session),'_' 'subject',num2str(subjectId),'_',date,'.xlsx'])

Temp=[]; Table=[]; Temp=Results.Subject(subjectId).Session(Session).Responses.DecisionPhase.Execution;
Table=table(Temp(:,1),Temp(:,2),Temp(:,3),Temp(:,4),Temp(:,5),Temp(:,6),Temp(:,7), ...
    Temp(:,8), Temp(:,9), Temp(:,10), Temp(:,11), Temp(:,12), Temp(:,13), Temp(:,14), ...
    'VariableNames',{'BlockNo','EffortLevel','Accuracy','RT', 'SwitchNumber','TrialType', 'Response', ...
    'Number', 'CorrectAnswer', 'Order', 'StartTrial', 'Trial', 'TrialStartTime', 'TrialStartSince' })
writetable(Table,['Decision_Execution_Session',num2str(Session),'_' 'subject',num2str(subjectId),'_',date,'.xlsx'])


save SeqPref Results
Screen('TextSize', display.windowPtr, textfont);
DrawFormattedText(display.windowPtr, 'Study is over. Thanks for your participation! ', 'center', 'center', [255 255 255], [100]);
Screen('Flip',display.windowPtr);
WaitSecs(WaitTime);
buttons=[];while 1;buttons =CedrusResponseBox('GetButtons', handle); if any(buttons); break; end; end; CedrusResponseBox('Close', handle); % close the Cedrus button box communication % check for button press

Screen('CloseAll');
ListenChar(0);
ShowCursor;

end
