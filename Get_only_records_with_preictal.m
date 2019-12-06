clc
clear all
close all
max_inter=15;
train_per=0.7;
N=4;
freq=256;
for pat=[18]
    fprintf('\n working now on patient %i \n' , pat);
    files=[];
    max_pre=0;
    count_inter=0;
    trainingfiles=[];
    testingfiles=[];
    train_len=0;
    test_len=0;
    for i=1:100        
        try
            load(['chb', num2str(pat,'%02.f'),'_',num2str(i, '%02.f'),'.mat']);
            files=[files; i];
        catch ME
            fprintf('\n could not load the file: %d_%d \n',pat,i); 
            continue;
        end
        if(sum(pre_true)>0)
            max_pre=max_pre+1;
        else
            if(count_inter<round(max_inter*train_per))
                count_inter=count_inter+1;
                trainingfiles=[trainingfiles; i];
                train_len=train_len+length(all_data{1});
            elseif(count_inter<max_inter)
                count_inter=count_inter+1;
                testingfiles=[testingfiles; i];
                test_len=test_len+length(all_data{1});

            end
        end
    end
    count_pre=0;
    for j=files'
        try
            load(['chb', num2str(pat,'%02.f'),'_',num2str(j, '%02.f'),'.mat']);
        catch ME
            fprintf('\n could not load the file (something terribly wrong happened): %d_%d \n',pat,j); 
            continue;
        end
        if(sum(pre_true)>0)
           if(count_pre<round(max_pre*train_per))
               count_pre=count_pre+1;
               trainingfiles=[trainingfiles; j];
               train_len=train_len+length(all_data{1});
           else
               testingfiles=[testingfiles; j];     
               test_len=test_len+length(all_data{1});
           end
        end        
    end
    trainingfiles=sort(trainingfiles);
    testingfiles=sort(testingfiles);
    trainingfiles'
    testingfiles'
    temp_len=1;
    templ_len=1;
    trainingdata=zeros(train_len,size(all_data,2));
%     trainiglabels=zeros(ceil(train_len/N/freq),1);
    traininglabels=[];
    for i=trainingfiles'
        try
            load(['chb', num2str(pat,'%02.f'),'_',num2str(i, '%02.f'),'.mat']);
        catch ME
            fprintf('\n could not load the file (something terribly wrong happened): %d_%d \n',pat,j); 
            continue;
        end
        trainingdata(temp_len:temp_len-1+length(all_data{1}),:) = cell2mat(all_data);
%         traininglabels(templ_len:templ_len-1+length(pre_true))=pre_true;
        traininglabels=[traininglabels; pre_true];
        temp_len=temp_len+length(all_data{1});
        templ_len=templ_len+length(pre_true);
        fprintf('\n loaded file %d_%d  to training data\n',pat,i);
    end
    temp_len=1;
    templ_len=1;
    testingdata=zeros(test_len,size(all_data,2));
%     testinglabels=zeros(test_len/N/freq,1);
    testinglabels=[];
    for i=testingfiles'
        try
            load(['chb', num2str(pat,'%02.f'),'_',num2str(i, '%02.f'),'.mat']);
        catch ME
            fprintf('\n could not load the file (something terribly wrong happened): %d_%d \n',pat,j); 
            continue;
        end
        testingdata(temp_len:temp_len-1+length(all_data{1}),:) = cell2mat(all_data);
%         testinglabels((templ_len):(templ_len-1+length(pre_true)))=pre_true;
        testinglabels=[testinglabels; pre_true];
        temp_len=temp_len+length(all_data{1});
        templ_len=templ_len+length(pre_true);
        fprintf('\n loaded file %d_%d  to testing data\n',pat,i);
    end
    fprintf('\n done with patient %i \n' ,pat)
save(['Patient',num2str(pat)],'-v7.3','trainingdata','testingdata','traininglabels','testinglabels','trainingfiles','testingfiles');
end
    