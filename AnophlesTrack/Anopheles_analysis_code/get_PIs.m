%%
cleanTracks = masterData.cleanTracks  

TimeZ2 = sum(vertcat(cleanTracks.TimeInZ2))
TimeZ1 = sum(vertcat(cleanTracks.TimeInZ1))
TimePI = (TimeZ2 - TimeZ1)./(TimeZ1 + TimeZ2)
%%
DistZ2 = sum(vertcat(cleanTracks.DistInZ2))
DistZ1 = sum(vertcat(cleanTracks.DistInZ1))
DistPI = (DistZ2 - DistZ1)./(DistZ2 + DistZ1)


%%
LandZ2 = sum(vertcat(cleanTracks.TimeInZ2)>0)
LandZ1 = sum(vertcat(cleanTracks.TimeInZ1)>0)
LandingPI = (LandZ2 - LandZ1)./(LandZ2 + LandZ1)