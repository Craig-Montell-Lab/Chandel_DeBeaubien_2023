function [meanTracks] = getMean(sTracks,LookBack)
if length(sTracks)>5
for i = 1:length(sTracks)
        TOI = sTracks(i).data;
        Range = round(size(TOI,1)/2):size(TOI,1);
        if length(Range)>LookBack
            Range = Range(end-LookBack):Range(end);
        end
        meanData = mean(TOI(Range,:),1,'omitnan');
        meanTracks(i,:) = meanData;
    end
else
    meanTracks = [];
end
