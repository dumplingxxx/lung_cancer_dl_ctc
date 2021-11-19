clc
clear
close all

CTC_Ind=2; % Index of CTC postivie Labels: 1 Pre 2 Post

rng('default')

load('results_for_survival_curves.mat');

%% Plot the km-curves

addpath 'MatSurv-master';
Labels_60=load('combined_recurrence_labels.mat');
Labels_60_CTCS=load('ctc_labels_60.mat');
GT_Recur=ceil(Labels_60.labels_test(:,1));
risk_60=risk_fused_pred;
risk_60=normalize(exp(risk_60),'range');

%% for the ctc based 
% convert the labels to matsurv format
Labels_CTC=Labels_60_CTCS.Labels_CTC(:,CTC_Ind);
Risk_Surv=risk_60;

EventVar=cell(60,1);
for m=1:60
    if Labels_60.labels_test(m,2)==1
        EventVar{m,1}='DECEASED';
    else
        EventVar{m,1}='LIVING';
    end
end


ind_high=find(Risk_Surv>median(Risk_Surv));
ind_low=find(Risk_Surv<=median(Risk_Surv));


 Group_Names=cell(60,1);
for k=1:60        
    if Labels_CTC(k,1)==1            
        Group_Names{k,1}='Positive';
    elseif Labels_CTC(k,1)==0 
        Group_Names{k,1}='Negative';
    end       
end



[p_ctc,fh_ctc,stats_ctc]=MatSurv(GT_Recur/30, EventVar, Group_Names, 'TimeUnit','Months', 'GroupOrder', {'Positive','Negative'},'BaseFontSize', ...
10, 'DispHR',false,'RT_YLabel',false, 'KM_position',[0.15 0.4 0.80 0.5],'RT_position',[0.15 0.05 0.80 0.20]);
 set(gcf,'position',[0,0,400,333]);



%% for the combined
Group_Names=cell(60,1);
ind_incr=find(Labels_CTC==1);
ind_decr=find(Labels_CTC==0);


for k=1:length(ind_high)

    if ismember(ind_high(k),ind_incr)
        Group_Names{ind_high(k),1}='Risk: high, positive';
    elseif ismember(ind_high(k),ind_decr)
        Group_Names{ind_high(k),1}='Risk: high, negative';
    else 
        continue
    end
end


for k=1:length(ind_low)

    if ismember(ind_low(k),ind_incr)
        Group_Names{ind_low(k),1}='Risk: low, positive';
    elseif ismember(ind_low(k),ind_decr)
        Group_Names{ind_low(k),1}='Risk: low, negative';
    else 
        continue
    end

end

[p_combined,fh_combined,stats_combined]=MatSurv(GT_Recur/30, EventVar, Group_Names,'LineColor',[0.74,0.24,0.16;1.00,0.41,0.16; 0.30,0.75,0.93; 0.00,0.45,0.76], ...
'GroupOrder',{'Risk: high, positive','Risk: high, negative','Risk: low, positive','Risk: low, negative'}, 'TimeUnit','Months', ...
'PairWiseP','true', 'BaseFontSize',10,'DispHR',false,'RT_YLabel',false, ...
'KM_position',[0.15 0.4 0.80 0.5],'RT_position',[0.15 0.05 0.80 0.20]);
set(gcf,'position',[0,0,400,333]);


% For High-low dl risks
Group_Names=cell(60,1);

for k=1:length(ind_high)
    if ismember(ind_high(k),ind_incr)
        Group_Names{ind_high(k),1}='Risk: high';
    elseif ismember(ind_high(k),ind_decr)
        Group_Names{ind_high(k),1}='Risk: high';
    else 
        continue
    end
end


for k=1:length(ind_low)
    if ismember(ind_low(k),ind_incr)
        Group_Names{ind_low(k),1}='Risk: low';
    elseif ismember(ind_low(k),ind_decr)
        Group_Names{ind_low(k),1}='Risk: low';
    else 
        continue
    end
end

[p_dl,fh_dl,stats_dl]=MatSurv(GT_Recur/30, EventVar, Group_Names,'GroupOrder',{'Risk: high','Risk: low'}, 'TimeUnit','Months', ...
'PairWiseP','true', 'BaseFontSize',10, 'DispHR',false, 'RT_YLabel',false,...
'KM_position',[0.15 0.4 0.80 0.5],'RT_position',[0.15 0.05 0.80 0.20]);
set(gcf,'position',[0,0,400,333]);    

