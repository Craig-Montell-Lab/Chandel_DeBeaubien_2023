%function for getting IR zones for anophles vidoes 
function [Params] = getzones(Params)
    Zones = {};
    for foldNumber = 1:length(Params.Folders)
        cd(Params.Folders{foldNumber})
        vidName = Params.vidNames{foldNumber}{1}
        
        vid = VideoReader(vidName)
        zFrame = readFrame(vid);
        zFrame = insertText(zFrame,[50 1],'Select Zone 1','FontSize',20);
        imshow(zFrame)
        hold on
        %select zone 1 
        z1 = [];
        for i = 1:4
           z1(i,:) = ginput(1); 
           zFrame = insertShape(zFrame,'FilledCircle',[z1 ones(size(z1,1),1)*10]); 
           imshow(zFrame)
           drawnow()
        end
        %zFrame = insertShape(zFrame,'FilledPolygon',[z1 flip(z1)],'Opacity',0.5); 
        imshow(zFrame)
        drawnow()
        
        %select zone 2
        zFrame = readFrame(vid);
        zFrame = insertText(zFrame,[50 1],'Select Zone 2','FontSize',20);
        zFrame = insertShape(zFrame,'FilledCircle',[z1 ones(size(z1,1),1)*10]); 
        %zFrame = insertShape(zFrame,'FilledPolygon',z1,'Opacity',0.5);
        imshow(zFrame)
        drawnow()
        z2 = [];
        for i = 1:4
           z2(i,:) = ginput(1); 
           zFrame = insertShape(zFrame,'FilledCircle',[z2 ones(size(z2,1),1)*10]); 
           imshow(zFrame)
           drawnow()
        end
       % zFrame = insertShape(zFrame,'FilledPolygon',z2,'Opacity',0.5); 
        imshow(zFrame)
        drawnow()
        Zones{foldNumber} = [z1,z2];
        cd(Params.FirstDir)

    end
    Params.Zones = Zones'
    
    close all
end