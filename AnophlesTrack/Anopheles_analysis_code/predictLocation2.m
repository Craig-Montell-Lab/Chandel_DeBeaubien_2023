%% predict new locations of tracks
function [tracks] = predictLocation2(tracks,sTracks)
for i = 1:length(tracks)
    tracks(i).age = tracks(i).age+1;
    % Predict the current location of the track.
    if tracks(i).age==1
        tracks(i).predictedCentroid = tracks(i).data;
    elseif tracks(i).consecutiveInvisibleCount==0
%         currId = ismember(tracks(i).id,vertcat(sTracks.id));
%         oldLocation = sTracks(currId).data(end,2:3);
        %tracks(i).predictedCentroid = currLocation + (oldLocation-currLocation);
        currLocation = tracks(i).data;
        tracks(i).predictedCentroid = currLocation;
    end
end