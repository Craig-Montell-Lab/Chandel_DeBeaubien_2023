clearvars 
Range = 1;
load('ZoneMaster.mat')
load('ExperimentNames.mat')
load('OutNames.mat')
ExpList = ExperimentNames(Range);
OutList = OutNames(Range);
%ReferenceList = vertcat(ZoneMaster{:,1});

for i = 1:size(ExpList,1)
ExpName1 = ExpList{i};
ExpName = strcat(ExpName1,'.mov');

OutName = OutList{i};
locator = Range(i);
boxes = ZoneMaster{locator,2};
X = boxes(:,1);
Y = boxes(:,2);

ExpName
MosquitoTrackerExpressv1
end


ExtractList = OutList;
Extraction = NaN(size(ExtractList,1),3);

for i = 1:size(ExtractList,1)
    ExpName = ExtractList{i};
    ExpName = strcat(ExpName,'.mat');
    
    if exist(ExpName, 'file') == 2;
        load(ExpName);
    Extraction(i,1) = FR;
    Extraction(i,2) = round(newPI,2);
    Extraction(i,3) = SeekingScore;
        
else
     'File Does Not Exist';
end

end
