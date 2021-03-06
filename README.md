# ParametricEffortSelectionTask

This is the adapted version of the Parametric Effort Selection used in Sayali & Badre, 2019. In this version, there are 4 effort levels. Effort is operationalized as task-switching. Across 4 effort levels, the probability of task switching varies between .13, .38, .63, .88 within blocks of 8 trials.

There are two phases to the experiment: Learning and Decision phases. The total task duration is around 40 minutes. In the Learning phase, each effort level is associated with a different deck of cards (color). Each deck is presented 10 times. First, participants view the deck the associated effort level is selected from. Next, they perform the associated effort level. 

In the Decision phase, participants make a choice between which deck to play from. There are 6 unique effort pairings (as there are 4 effort levels) and there are 12 total presentations of each pairing.The Decison Phase is optimized (using optseq2) for a fMRI session with TR of .72.

There can be 2 sessions (Test, Re-Test, e.g. drug sessions) to the experiment. On each session, different color of decks of cards are used for effort-level associations and on each session, different hand-rule mappings are used. 

## Instructions
Download the SeqPref folder and run the 'StudyWrapper.m' on Matlab (Psychtoolbox installed). Run as a function, this script sets path to the folder the function is stored and its subfolder (PsychtoolNeces). 

When prompted, enter Subject ID, indicate which session it is (whether it is Test or reTest, e.g. drug sessions) and indicate whether it is Learning or Decision Phase. Learning phase of a session (Test or Re-Test) needs to be performed before the Decision Phase of the same session, using the same subject ID. If a subject ID has not entered the Learning Phase, Decision Phase script will not work.  

The data is stored in 2 ways: 1) live updated in SeqPref.mat in the project folder under Results.Subject(subjectId), 2) saved as an excel file for each subject Id, Session, Phase and date.

## Contributing
Fork this project and open a pull request.
