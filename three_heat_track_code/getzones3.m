%function for getting IR zones for anophles vidoes 
function [Params] = getzones3(Params)
    Zones = {};
    for foldNumber = 1:length(Params.FilePath)
        [Z1,Z2,frame] = gZone2(Params,foldNumber);
        
       %show zone vertices 
       zFrame = insertShape(frame,'FilledCircle',[Z1 ones(length(Z1),1)*10],'Color', [255 0 0]); 
       zFrame = insertShape(zFrame,'FilledCircle',[Z2 ones(length(Z1),1)*10],'Color',[0 0 255]); 

       imshow(zFrame)
       drawnow()
       %ask if zones are correct
       answer = questdlg('Are zones correct?', ...
           'Yes','Yes',...
           'No','No');
       % Handle response
       switch answer
           case 'Yes'
               disp([answer ':)'])
               Zones{foldNumber,1} = Z1;
               Zones{foldNumber,2} = Z2;
           case 'No'
               disp([answer ':('])
               [Z1,Z2,frame] = gZone(Params,foldNumber);
               Zones{foldNumber,1} = Z1;
               Zones{foldNumber,2} = Z2;
       end
       
    
    close all
    end
    Params.Zones = Zones
