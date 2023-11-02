%% distance data analysis for aedes 
addpath(pwd)
addpath('Path to code here')
%% build parameters structure
Params = struct();
Params.FirstPath = pwd;
%% get directory of interest (add directory to video file(s) here)
selpath = uigetdir;
cd(selpath)
dirContents = dir('**/*.*') ;
strIdx = (strfind({dirContents.name},'.wmv'));
strIdx = ~cellfun(@isempty,strIdx);
dirContents = dirContents(strIdx);
%% get directory of interest 
Params.FilePath = {dirContents.name}'

%% get IR zones 
[Params] = getzones3(Params);
if ~isempty(Params.Zones)
    save("Conduction_Params.mat","Params")
end

%% run IR tracking 
moquito_track_launch
%% save table 
writetable(masterTable,'masterTable.csv')



