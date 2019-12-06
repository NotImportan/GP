function [TP,TN,FP,FN]=detection_performance(Classification,seizure_true)
TP=0;TN=0;FP=0;FN=0;

for i=1:length(Classification)
    if(Classification(i)==1)&&(seizure_true(i)==1)
        TP=TP+1; fprintf('there is seizure : %i \n',TP);
    elseif(Classification(i)==0)&&(seizure_true(i)==0)
        TN=TN+1;
    elseif(Classification(i)==1)&&(seizure_true(i)==0)
        FP=FP+1;
    elseif(Classification(i)==0)&&(seizure_true(i)==1)
        FN=FN+1;
    end
end