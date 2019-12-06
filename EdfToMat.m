EDF to mat conversion - https://www.mathworks.com/matlabcentral/fileexchange/38641-reading-and-saving-of-data-in-the-edf
% 
 filePath_edfSource = 'D:\MIT dataset\chb01_01.edf';
 filePath_matDestination = 'D:\MIT dataset\chb01_01.mat';
% 
 [data, header] = readEDF(filePath_edfSource);
 data = cell2mat(data);
  save(filePath_matDestination, 'data');
% 
% [data,header]=readEDF('D:\Graduation Project\Abdullah codes\chb06\chb06_01.edf');
% % data=cell2mat(data);
% 
% 
% save('chb06_01.mat','data');