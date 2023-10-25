%% Anophles IR track launch 
YourPath = 'YourPathtoAnophlesTrackCodeGoesHere'
addpath(YourPath) %add path to functions associated with Anophles track here

%% get directory of interest (add directory to video files here)
selpath = uigetdir;
cd(selpath)
dirContents = dir('**/*.*') ;
strIdx = (strfind({dirContents.name},'.'));
strIdx = cellfun(@isempty,strIdx);
dirContents = dirContents(strIdx);


%% create parameters object 
Params.FirstDir = pwd; %first directory to return to 
fullPath = {}
for i = 1:length(dirContents)
    fullPath{i,1} = strcat(dirContents(i).folder,'\',dirContents(i).name)
end
    
Params.Folders = fullPath
% get videos in each folder
allFiles = {}
for kk = 1:size(Params.Folders,1)
    cd(Params.Folders{kk})
    fileList = dir('*.wmv')'
    fileList = {fileList.name}'
    allFiles{kk,1} = fileList
    cd(Params.FirstDir)
end
Params.vidNames = allFiles;

%get IR zones for each cage 
[Params] = getzones(Params)
%save parameters 
saveName = 'Params';
save(saveName,"Params")

%% Run tracking program in loop (this will loop over videos in directory of interest)
for foldNumber = 1:length(Params.Folders)
    cd(Params.Folders{foldNumber})
    for vidNumber = 1:length(Params.vidNames{foldNumber})
        vidName = Params.vidNames{foldNumber}{vidNumber}
        
        %run IR tracking program
        IR_trax
        
        %get data 
        %loop_get_data
        
        %store output data
        masterData.allTracks = sTracks
        masterData.cleanTracks = cleanTracks
        
%         dataTable = table();
%         dataTable.TimeInZone1 = TimeZ1;
%         dataTable.TimeInZone2 = TimeZ2;
%         dataTable.TimePI = TimePI;
%         
%         dataTable.DistInZone1 = DistZ1;
%         dataTable.DistInZone2 = DistZ2;
%         dataTable.DistPI = DistPI;
%         
%         dataTable.LandingInZone1 = LandZ1;
%         dataTable.LandingInZone2 = LandZ2;
%         dataTable.LandingPI = LandingPI;
%         masterData.dataTable = dataTable;
        %save data 
        saveName = vidName(1:end-4)
        save(saveName,"masterData")
        clearvars -except Params foldNumber vidNumber
    
    end
    cd(Params.FirstDir)
end








