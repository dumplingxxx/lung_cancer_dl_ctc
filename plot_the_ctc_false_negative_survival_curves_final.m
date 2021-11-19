clc
clear
close all


%% for the 6 ctc negative patients
% load the survival curves data
load('results_for_survival_curves.mat');
index_fn_ctc=[46,5,30,15,25,27];

[val_sort,ind_sort]=sort(risk_fused_pred);

% the median of 30 low-risk patients
index_median_risk=ind_sort(15);

% plot the survival curves
figure 
hold on

for ind_sel=1:length(index_fn_ctc)
  
   plot(survival_times/30,survival_values(index_fn_ctc(ind_sel),:),'r','DisplayName',['patient-',num2str(ind_sel)],'LineWidth',1.5);  
    
end
 

plot(survival_times/30,survival_values(index_median_risk,:),'b--','DisplayName','median of low risk','LineWidth',1.5);

box on
grid on

xlabel('survival time (months)','FontWeight','bold','FontSize',11)
ylabel('survival probability','FontWeight','bold','FontSize',11)

set(legend,'FontWeight','bold','FontSize',11);
set(gcf,'position',[0,0,600,400]);


%% for all the 60 patients

Labels_60_CTCS=load('data_for_results/ctc_labels_60.mat');

ctc_60=Labels_60_CTCS.Labels_CTC(:,2);
[val_risk, ind_risk]=sort(risk_fused_pred);

surv_high=survival_values(ind_risk(31:end),:);
surv_low=survival_values(ind_risk(1:30),:);

ind_high_pos=find(ctc_60(ind_risk(31:end))==1);
ind_high_neg=find(ctc_60(ind_risk(31:end))==0);
ind_low_pos=find(ctc_60(ind_risk(1:30))==1);
ind_low_neg=find(ctc_60(ind_risk(1:30))==0);

% plot the survival curves
figure 
hold on

for ind_sel=1:length(ind_high_pos)
 
   h_1=plot(survival_times/30,surv_high(ind_high_pos(ind_sel),:),'Marker','d','Color',[189 61 41]/255,'LineWidth',1.5);  
    
end
 

for ind_sel=1:length(ind_high_neg)

    
   h_2=plot(survival_times/30,surv_high(ind_high_neg(ind_sel),:),'Color',[255 105 41]/255,'LineWidth',1.5);  
    
end

for ind_sel=1:length(ind_low_pos)

    
   h_3=plot(survival_times/30,surv_low(ind_low_pos(ind_sel),:),'Marker','d','Color',[77 191 237]/255,'LineWidth',1.5);  
    
end
 

for ind_sel=1:length(ind_low_neg)

    
   h_4=plot(survival_times/30,surv_low(ind_low_neg(ind_sel),:),'Color',[0 115 194]/255,'LineWidth',1.5);  
    
end

grid on
box on

xlabel('survival time (months)','FontWeight','bold','FontSize',11)
ylabel('survival probability','FontWeight','bold','FontSize',11)

legend([h_1,h_2,h_3,h_4],'Risk: high, positive', 'Risk: high, negative','Risk: low, positive', 'Risk: low, negative',...
'FontWeight','bold','FontSize',11);



set(gcf,'position',[0,0,600,400]);
