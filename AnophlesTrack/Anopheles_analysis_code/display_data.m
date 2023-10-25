%% display data 
maxT = max(vertcat(cleanTracks.trackedFrames));
%create empty data container
dispData = cell(1,max(vertcat(cleanTracks.id)));
for i = 1:length(dispData)
    dispData{1,i} = nan(maxT,11);
end

for i = 1:length(dispData)
  trackedFrames = cleanTracks(i).trackedFrames;
  dispData{1,i}(trackedFrames,:) = cleanTracks(i).data;
end

%display loop
vid.CurrentTime = 0
videoPlayer = vision.VideoPlayer;

for i = 1:maxT
    frame = readFrame(vid);
    %frame = frame(yRange,xRange,:);

    XYs = [];
    for ii = 1:length(dispData)
      XYs = [XYs;dispData{1,ii}(i,2:3)];
    end
    XYs(:,3) = (1:size(XYs,1))';
    XYs = XYs(all(~isnan(XYs(:,1)),2),:);

    if isempty(XYs)
        sFrame = frame;
    else
        sFrame = insertShape(frame,'FilledCircle',[XYs(:,1:2), ones(size(XYs,1),1).*1],'color','red');
        sFrame = insertText(sFrame,XYs(:,1:2),cellstr(num2str(XYs(:,3))),'FontSize',20,'BoxOpacity',0);
    end
    videoPlayer(sFrame)
    pause(1/30)
end

    
    
    
    
