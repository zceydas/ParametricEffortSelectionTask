load('/Users/csayali/Dropbox/DCCN/Marlene task/SeqPref/SeqPref.mat')
% load Marlene's pilot task, subject no =1
 int=0;
for s=3
    int=int+1;
    figure
    Temp=[];
    Temp=Results.Subject(s).Responses.Practice;
    colors=['r','b','g','m'];
    each=[]; amount=[];
    
    subplot(1,4,1)
    for k=1:10; amount=[amount;repmat(1,8,1)*k]; end
    for task=1:4
        each=Temp((Temp(:,1)==task),:); each=[each amount];
        for block=1:10
            Block=each((each(:,end)==block),:);
            Acc(task,block)=mean(Block((Block(:,2)<9),2));
            CorrectRT(task,block)=mean(Block((Block(:,2)==1),3));
        end
        hold on
        plot(Acc(task,:),colors(task))
        RTs(task).Lev(int,:)=CorrectRT(task,:);
        Accuracies(task).Lev(int,:)=Acc(task,:);
    end

    legend('Simple','Easy','Intermediate','Random')
    xlabel('Trial No')
    ylabel('Accuracy')
    
    subplot(1,4,2)
    for task=1:4
        hold on
        plot(CorrectRT(task,:),colors(task))
    end
    legend('Simple','Easy','Intermediate','Random')
    xlabel('Trial No')
    ylabel('Correct RT')
    
    subplot(1,4,3)
   
    Temp=[]; Temp=Results.Subject(s).DecisionPhase.Responses.Test;
    Temp(:,7)=1.5-Temp(:,3); % calculate the offer difference between options (Simple task being 1.5 always)
    levs=unique(Temp(:,3));
    diflevs=unique(Temp(:,7));
    tasks=unique(Temp(:,2));
    MidPoint(1:3)=nan;
    colors={'*r' '*g' '*b' 'r' 'g' 'b'};
    Pfunc=[]; OverallP=[]; Pfuncdif=[];
    for i=1:length(tasks)
        temp=[];
        temp=Temp((Temp(:,2)==tasks(i)),:);
        x=[]; y=[];
        x=temp(:,3); y=temp(:,1);
        % below Danae's IP coding
        eqProb=0.5;
        betas = glmfit(x, y,'binomial','link','logit');
        yfit = glmval(betas, x, 'logit');
        IP=(log(eqProb/(1-eqProb))-betas(1))/betas(2);
        MidPoint(i)=IP;
        %
        for v=1:length(levs)
            Pfunc(i,v)=mean(temp((temp(:,3)==levs(v)),1));
        end
        for v=1:length(diflevs) % calculate the probability of selection at each offer difference level
            Pfuncdif(i,v)=mean(temp((temp(:,7)==diflevs(v)),1));
        end
        
        hold on
        plot(Pfunc(i,:),colors{i})
        hold on
        
        OverallP(i)=mean(Pfunc(i,:)');
        AvLowOffer(i,1)=mean(temp((temp(:,3)<1.5),1));
        
    end
    OverallSimpleTaskChoice(int)=length(find(Temp(:,1)==0))/length(Temp(:,1));
    title('Decision Phase')
    legend('Easy','Int','Random')
    %legend('Easy','EasyFit','Int','IntFit','Dif', 'DifFit')
    %legend('Easy','Int','IntFit','Dif', 'DifFit')
    set(gca,'XTick',[1:length(levs)])
    set(gca,'XTickLabel',levs)
    xlabel('Offered Amount','FontSize', 15)
    ylabel('P (accepting offer)','FontSize', 15)
    MeanMidPoint(int,:)=MidPoint;
    MeanMidPoint(isnan(MeanMidPoint))=3.1;
    
    
    % report the probability choice at each offer difference for each
    % subject. Smaller offer differences mean that the harder task was
    % paired with greater reward
    for task=1:3
        Choices(task).lev(int,:)=Pfuncdif(task,:);
    end

    
    subplot(1,4,4)
    % if sum(isnan(MidPoint))>0
    %     plot(MidPoint,'*r','LineWidth',2)
    % else
    %     plot(MidPoint,'LineWidth',2)
    % end
    plot(OverallP)
    title('Decision Phase')
    set(gca,'XTick',[1:3])
    set(gca,'XTickLabel',str2mat('Easy','Intermediate','Random'))
    ylabel('OverallSelectionP','FontSize', 15)
    MeanOverallP(int,:)=OverallP;

end
%% Group level
colors={'r','g','b','m'};
figure
subplot(2,2,1)
for task=1:4
    hold on
    y=[];
    y=RTs(task).Lev; x=[1:length(y)];
    mean_y = mean(y);
    std_y = WithinSubjectError(y);
    shadedErrorBar(x, y, {@mean, @(x) std_y}, 'lineprops',colors(task));
end
legend('TS0','TS1','TS3Seq','TS3Rnd')
xlabel('Trial No')
ylabel('Correct RT')

subplot(2,2,2)
for task=1:4
    hold on
    y=[];
    y=Accuracies(task).Lev; x=[1:length(y)];
    mean_y = mean(y);
    std_y = WithinSubjectError(y);
    shadedErrorBar(x, y, {@mean, @(x) std_y}, 'lineprops',colors(task));
end
%legend('TS1','TS2','TS3Seq','TS3Rnd')
xlabel('Trial No')
ylabel('Accuracy')


subplot(2,2,[3:4])
for task=1:3
    y=[];
    y=Choices(task).lev; x=[1:length(y)];
    mean_y = mean(y);
    std_y = WithinSubjectError(Choices(task).lev);
    hold on
    shadedErrorBar(x, y, {@mean, @(x) std_y}, 'lineprops',colors(task+1));
end
set(gca,'XTick',[1:length(diflevs)])
set(gca,'XTickLabel',diflevs)
ylabel('Overall Choice %','FontSize', 15)
xlabel('Offer Difference','FontSize', 15)
legend('TS1','TS3Seq','TS3Rnd')


