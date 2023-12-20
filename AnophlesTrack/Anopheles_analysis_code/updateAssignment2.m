%% Update Assigned Tracks
function [tracks] = updateAssignment2(tracks,assignments,DT)
if ~isempty(assignments)
numAssignedTracks = size(assignments, 1);
for i = 1:numAssignedTracks
    detectionIdx = assignments(i, 1);
    trackIdx = assignments(i, 2);

    % Replace data with matches 
    tracks(trackIdx).data = DT(detectionIdx,:);

    % Update visibility.
    tracks(trackIdx).totalVisibleCount = ...
        tracks(trackIdx).totalVisibleCount + 1;
    tracks(trackIdx).consecutiveInvisibleCount = 0;
end
end