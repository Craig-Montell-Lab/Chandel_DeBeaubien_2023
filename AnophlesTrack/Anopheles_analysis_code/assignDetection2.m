%% Assign Detections to Tracks
function [assignments,unassignedTracks,unassignedDetections] = ...
    assignDetection2(tracks,DT,speedThresh)

% assign detections 
nTracks = length(tracks);
nDetections = size(DT,1);

% Compute the cost of assigning each detection to each track.
%               *this cost function will probably need to be modified*
cost = zeros(nDetections,nTracks); %rows are detections; columns are tracks

for i = 1:nTracks
    
    QueryPoints = tracks(i).predictedCentroid(1,2:3);
    [~,dist] = knnsearch(QueryPoints,DT(:,2:3));
    cost(:,i) = dist;

end
if sum(isnan(cost),'all')>0
    cols 
end

% filter for speed 
keeper_idx = cost<speedThresh;

% assign detections 
    %loop to find min value if >1 detection survives speed thresh
    assIdx = find(any(keeper_idx,1));
    for i = 1:length(assIdx)
        keeper_idx(:,assIdx(i))  = cost(:,assIdx(i))==min(cost(:,assIdx(i)));
    end
    
    %loop to find min value if >1 detection matches to track
    assIdx = find(any(keeper_idx,2));
    for i = 1:length(assIdx)
        keeper_idx(assIdx(i),:)  = cost(assIdx(i),:)==min(cost(assIdx(i),:));
    end

[assignmentsX,assignmentsY] = find(keeper_idx>0);
assignments = [assignmentsX,assignmentsY];

%find unassigned tracks 
unassignedTracks = find(~any(keeper_idx,1));

%find unassigned detections 
unassignedDetections = find(~any(keeper_idx,2));
end

