function [tracks,nextId] = newTracks2(tracks,unassignedDetections,DT,nextId)
%% create new tracks (could be lit)
data = DT(unassignedDetections, :);
for i = 1:size(data, 1)

    centroid = data(i,:);

    % Create a new track.
    newTrack = struct(...
        'id', nextId, ...
        'data', data(i,:), ...
        'totalVisibleCount', 1, ...
        'consecutiveInvisibleCount', 0, ...
        'predictedCentroid',centroid,...
        'age',1);

    % Increment the next id.

        nextId = nextId + 1;
    
    % Add it to the array of tracks.
    tracks(end + 1) = newTrack;

end
end

