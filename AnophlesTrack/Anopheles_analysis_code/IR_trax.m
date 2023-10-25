vid = VideoReader(vidName)
addpath(YourPath)
%generate mode background model
ModeBackgroundModel

%% detecting 
hblob = vision.BlobAnalysis(...
    'CentroidOutputPort', true, ...
    'AreaOutputPort', true, ...
    'BoundingBoxOutputPort', true, ...
    'MinimumBlobAreaSource', 'Property',...
    'MajorAxisLengthOutputPort',true,...
    'MinorAxisLengthOutputPort',true,...
    'BoundingBoxOutputPort',true,...
    'EccentricityOutputPort',true,...
    'OrientationOutputPort',true,...
    'MinimumBlobArea', 50, ...
    'MaximumBlobArea', 190, ...
    'MaximumCount',10000);%blob detector

vid.CurrentTime = 0;
counter = 1
data = {}
% videoPlayer = vision.VideoPlayer;

while hasFrame(vid)
    frame = (readFrame(vid));
    %frame = frame(yRange,xRange,:);
    dframe = extractForeground(frame,uint8(mode_model),10);
    [Areas,CTs,BB,MALs,MiALs,Orients,Ecens] = hblob(dframe);
%     for i = 1:size(Areas,1)
%         
%         moi = dframe(BB(i,2):BB(i,2)+BB(i,4)-1,BB(i,1):BB(i,1)+BB(i,3)-1);
%         maskedImage = imcomplement(frame(BB(i,2):BB(i,2)+BB(i,4)-1,BB(i,1):BB(i,1)+BB(i,3)-1));
%         maskedImage(~moi) = 0;
%         Areas(i,1) = sum(maskedImage,'all');
%     end
%     showIm = imshowpair(frame,dframe);
%     drawnow()
%     delete(showIm)
    data{counter,1} = [double(Areas),double(CTs),double(BB),double(MALs),double(MiALs),double(Orients),double(Ecens)];
    DT = data{counter,1};
    counter = counter + 1
end

%% matching 
% Detect moving objects, and track them across video frames.

counter = 1; 
speedThresh = 10;
LookBack = 10;

[tracks] = creatFirstTrack2(data) %create empty structure for track data 
[sTracks] = storeTracks(tracks,nan,counter) %create empty structure for stored data 

nextId = size(tracks,1)+1
GO = 1
while GO == 1 && counter< size(data,1)

    DT = data{counter,1};
    
    [tracks] = predictLocation2(tracks,sTracks); %predicted location currently set to current location.
    
    [assignments,unassignedTracks,unassignedDetections] = ...
    assignDetection2(tracks,DT,speedThresh);

    %update assigned tracks 
    [tracks] = updateAssignment2(tracks,assignments,DT);
    
    %update unassigned tracks
    [tracks,del_ids] = confusingtracks(tracks,unassignedTracks);

    %create new tracks
    [tracks,nextId] = newTracks2(tracks,unassignedDetections,DT,nextId);
    
    [sTracks] = storeTracks(tracks,sTracks,counter,del_ids);

    %correct mis-assignments
    %[meanTracks] = getMean(sTracks,LookBack);

    %[tracks]= assignmentCoorection(tracks,meanTracks);
    counter = counter + 1
    
end

%clean up sTracks data 
minVisibleFrames = 10%minimum number of visible frames 
[cleanTracks] = cleanSTracks2(sTracks,minVisibleFrames);

% display tracking results
%display_data


% analyze the data...
%things I want: time in zone(X), landings in zone(), distance in zone()
z1 = Params.Zones{foldNumber}(:,1:2)
z2 = Params.Zones{foldNumber}(:,3:4)

TimeInZ1 = [];
TimeInZ2 = [];

DistInZ1 = [];
DistInZ2 = [];
for i = 1:max(vertcat(cleanTracks.id))
    
    currTrack = cleanTracks(i).data;
    
    [in_Z1] = inpolygon(currTrack(:,2),currTrack(:,3),z1(:,1),z1(:,2));
    [in_Z2] = inpolygon(currTrack(:,2),currTrack(:,3),z2(:,1),z2(:,2));
    
    %Time in Zones 
    TimeInZ1(i,1) = sum(in_Z1)/vid.FrameRate;
    TimeInZ2(i,1) = sum(in_Z2)/vid.FrameRate;
    
    %Distance in Zones 
    DistInZ1(i,1) = sum(sqrt((diff(currTrack(in_Z1,2)).^2) + (diff(currTrack(in_Z1,3)).^2)));
    DistInZ2(i,1) = sum(sqrt((diff(currTrack(in_Z2,2)).^2) + (diff(currTrack(in_Z2,3)).^2)));
end
%store output 
for i = 1:size(TimeInZ1,1)
    cleanTracks(i).TimeInZ1 = TimeInZ1(i);
    cleanTracks(i).TimeInZ2 = TimeInZ2(i);
    
    cleanTracks(i).DistInZ1 = DistInZ1(i);
    cleanTracks(i).DistInZ2 = DistInZ2(i);
    
end








