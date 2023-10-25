%% Create tracks object :)
function [tracks] = creatFirstTrack2(data)
%create first frame
% create an empty array of tracks
tracks = struct(...
    'id', {}, ...
    'data', {}, ...
    'totalVisibleCount', {}, ...
    'consecutiveInvisibleCount', {},...
    'predictedCentroid',{},...
    'age',{});

ids = 1:size(data{1,1})
%ids
for i = 1:length(ids)
    tracks(i,1).id = ids(1,i);
end
%data
for i = 1:length(ids)
    tracks(i,1).data = data{1,1}(i,:);
end

%visibility count
for i = 1:length(ids)
     tracks(i,1).totalVisibleCount = 1;
end
%invisible count 
for i = 1:length(ids)
    tracks(i,1).consecutiveInvisibleCount = 0;
end
%age count 
for i = 1:length(ids)
    tracks(i,1).age = 0;
end