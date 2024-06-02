exps = 1208
% cords = ZoneMaster{1790,2};
load('ZoneMaster.mat')
load('ExperimentNames.mat')

dlgtitle = 'Input Movie File to Analyze';
    prompt = {'Enter File Name with Extension:'};
    definput = {'.mov'};
    dims = [1 70];
    file_specs = inputdlg(prompt,dlgtitle,dims,definput);
    file_name = file_specs{1};
    v = VideoReader(file_name);
    FR = v.FrameRate;

 findbox = readFrame(v);
findzones = figure('Position',[100 100 v.Width*1.5 v.Height*1.5]);
daspect([1 1 1])
    image(findbox);
    hold on;
    
    [X,Y] = ginput(8);
    close(findzones);

clearvars -except X Y exps ZoneMaster ExperimentNames

cords = [X,Y];
for i = 1:length(exps)
    ind = exps(i)
    ZoneMaster(ind,2) = {cords};
    ZoneMaster(ind,1) = {ExperimentNames{ind}}
end

clearvars -except ZoneMaster
save('ZoneMaster.mat')

