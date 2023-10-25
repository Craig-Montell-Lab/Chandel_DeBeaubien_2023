function sTracks = storeTracks(tracks,sTracks,counter)
if counter == 1         
% create an empty array of tracks
        sTracks = struct(...
            'id', {}, ...
            'data',{},...
            'trackedFrames', 1);
end

ids = 1:size(vertcat(tracks.id),1)
for i = 1:length(ids)
    IDpos = ids(i);
    sTracks(IDpos) = IDpos;
    catFrames = [sTracks(IDpos,1).trackedFrames;tracks(i).trackedFrames];
    sTracks(IDpos,1).trackedFrames = catFrames;

    %concatenate data 
    catData = [sTracks(IDpos,1).data;tracks(i).data(1,:)];
    sTracks(IDpos,1).data = catData;
end

end