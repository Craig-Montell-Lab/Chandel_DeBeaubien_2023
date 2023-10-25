function [tracks]= assignmentCoorection(tracks,meanTracks)
MatchThresh = 10;
cost = [];
tracks = tracks;
if ~isempty(meanTracks)
    % assign detections
    nTracks = length(tracks);
    nDetections = size(meanTracks,1);
    cost = zeros(nDetections,nTracks);
    for i = 1:nTracks
        QueryPoints = tracks(i).predictedCentroid(1,1:7);
        [~,dist] = knnsearch(QueryPoints,meanTracks(:,1:7));
        cost(:,i) = dist;
    end
    keeper_idx = cost<MatchThresh;
    if sum(keeper_idx,'all')>0
        %cols
        [swapStored,swapTracks] = find(keeper_idx==1);
        swaps = [swapStored,swapTracks];
        
        for i = 1:size(swaps,1)
            if tracks(swaps(i,2)).id ~= swaps(i,1)
                %cols 
                tracks(i).id = swaps(i,1);
                tracks(swaps(i,2)).id
                disp('FLOP')
            end
        end
    end
end


