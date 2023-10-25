function sTracks = storeTracks(tracks,sTracks,counter,del_ids)
if counter == 1         
% create an empty array of tracks
        sTracks = struct(...
            'id', {}, ...
            'data',{},...
            'trackedFrames', 1);

else
ids = vertcat(tracks.id);
for i = 1:length(ids)
    IDpos = ids(i);
    sTracks(IDpos).id = IDpos;
    catFrames = [sTracks(IDpos).trackedFrames;counter];
    sTracks(IDpos).trackedFrames = catFrames;

    %concatenate data 
    catData = [sTracks(IDpos).data;tracks(i).data(1,:)];
    sTracks(IDpos).data = catData;
end
end
%delete bad tracks/matches
% if nargin <4
%     del_ids = [];
% end
% if ~isempty(del_ids)
%     del_idx = ismember(vertcat(sTracks.id),del_ids);
%     sTracks(del_idx) = [];
% end
