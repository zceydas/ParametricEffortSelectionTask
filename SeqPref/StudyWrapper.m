function [Results]=StudyWrapper()
%%%%%% Wrapper function for the revised and reoptimized Effort %%%%%%%%%%%%
%%%%%% Selection Task designed by Ceyda Sayali, August 5, 2020 %%%%%%%%%%%%
%%%%%% There are two phases to this experiment: Learning and Selection %%%%
%%%%%% Specify which phase you want to run by responding 1(Learning) %%%%%%
%%%%%% 2 (Selection) to the session prompt. Each participant enters %%%%%%%
%%%%%% the first (Learning) phase before second (Selection). %%%%%%%%%%%%%%
%%%%%% This study can be run twice on the same participant (test/retest) %%
%%%%%% Selection Phase ITIs are optimized for fMRI hybrid design with a %%%
%%%%%% TR of 720 ms. %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Results (SeqPref.mat) is the main data output along with the %%%%%%%
%%%%%% excel files in the created subject subfolder %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Set Directory %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
st = dbstack;
namestr = st.name;
directory=fileparts(which([namestr, '.m']));
cd(directory)
addpath(directory) % set path to necessary files
addpath(fullfile(directory,'PsychtoolNeces'))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%% Subject specific input %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subjectId=input('What is subject ID?');
Session=input('What is study session? Test(1), ReTest(2): '); % this can be 1 or 2 (test and re-test)
Phase=input('What is study phase? Learning(1), Decision(2): '); % this can be 1 or 2 (1 is Learning, 2 is Test)
if mod(subjectId,Session+1) == 1 % two different sets of cards for 2 separate sessions
    colorlist = {'Blue','Green','Yellow','Red'}; %these letters will be used for selecting the card images
else
    colorlist = {'Grey','Orange','Purple','Turco'}; %these letters will be used for selecting the card images
end
datafileName = ['ID_' num2str(subjectId) '_Data Folder'];
if ~exist(datafileName, 'dir')
  mkdir(datafileName);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%% Phase general values %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MaxLevel = 4; %how many difficulty levels there are in terms of the number of task switches
letterperm=perms(colorlist); %subjects are assigned to different card colors based on their subject no
NoNumbers = 8; %how many numbers should be generated in total for each difficulty condition (task switch blocks)
exclude = 5; %which number should be excluded from the list (for making the magnitude judgment)
WaitTime = .5; %duration of feedback messages/notations
FixDur = .2; %duration of the fixation cross between number presentations (card)
UntilKey = .15; %for how long keyboard will ignore reponses during task presentation
PracticeContextDur = 1; % how long each deck image should stay on the screen in the Learning Phase
TrialDeadline = 1.5; % trial deadline for each task switch trial
ITI = 2; %average ITI in the Learning Phase
ISI = 2; % how long the chosen card image stays on the screen in the Decision Phase - and so is the ISI as well
SelectionDeadline = 3; % the deadline for selection epoch
Instructions = 0; % should remain 0 if you don't want accuracy feedback throughout Learning and Decision phases (not Practice obviously)
global MaxLevel subjectId Session letterperm NoNumbers exclude WaitTime FixDur UntilKey PracticeContextDur TrialDeadline ITI SelectionDeadline ISI
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Phase specific values %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
NoTrial =  10; %number of trials for each unique level in the Learning Phase
global NoTrial
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% keyboard responses %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
KbName('UnifyKeyNames')
KeyTemp=KbName('KeyNames');
rightkey = KbName('RightArrow');%'RightArrow';
leftkey = KbName('LeftArrow');%LeftArrow';  
endcode =  find(strcmp(KeyTemp, 'ESCAPE' )); %escape key - if you press Escape during the experiment, study will pause until next key stroke
global rightkey leftkey endcode
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% Setup Screen %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Screen('Preference', 'SkipSyncTests', 1);
Screen('Preference','VisualDebugLevel', 0);
%PsychDebugWindowConfiguration(0,0.5) % for debugging purposes
screens=Screen('Screens');
screenNumber=max(screens);
[display.windowPtr, windowRect]=Screen('OpenWindow', screenNumber, 0, [], 32, 2);
display = OpenWindow(display);
ifi=Screen('GetFlipInterval', display.windowPtr);
if display.frameRate==0
    display.frameRate=1/ifi;
end
Screen('TextSize', display.windowPtr, 25);
Priority(MaxPriority(0));
HideCursor;	% Hide the mouse cursor
centerX = display.resolution(1)/2;
centerY = display.resolution(2)/2;
global display centerX centerY windowRect
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Final Misc Psychtoolbox Setup - dummy calls, etc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Randomize Random Generators
cccc = clock;
s = RandStream('mt19937ar','Seed',cccc(6));
turns = randi(s,100);
for i = 1:turns
    randsample(10,5);
end
KbName('UnifyKeyNames') %enables cross-platform key id's
[keyIsDown,secs,keyCode] = KbCheck;
WaitSecs(0.1);
GetSecs;
PsychWatchDog;
ListenChar(2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Phase specific functions %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
switch Session
    case {1,2}
        switch Phase
            case 1 % Learning Phase
                [Results] = LearningPhaseSequence(Instructions);
                files = dir(['*_subject' num2str(subjectId) '*.xlsx']);                
                for f=1:length(files)
                movefile(fullfile(files(f).folder,files(f).name), datafileName)
                end
            case 2 % Decision Phase
                [Results] = DecisionPhaseSequence(Instructions);
                files = dir(['*_subject' num2str(subjectId) '*.xlsx']);                
                for f=1:length(files)
                    movefile(fullfile(files(f).folder,files(f).name), datafileName)
                end
            otherwise
                Screen('CloseAll');
                ListenChar(0);
                ShowCursor;
                fprintf('\n')
                disp('>>> Phase number can be only 1 (learning) or 2 (decision)!!! <<<')
        end
    otherwise
        Screen('CloseAll');
        ListenChar(0);
        ShowCursor;
        fprintf('\n')
        disp('>>> Session number can be only 1 (test) or 2 (retest)!!! <<<')
end

