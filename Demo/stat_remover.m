function [newPI,final_pts,point_distance,points_out] = stat_remover(track_set,trax_X,trax_Y,X,Y,fsize,framelimit)
dis_thresh = fsize;
trav_thresh = 10;
moving_traces = cell(1,size(track_set,2));



    tXmat = trax_X;
    empty = find(cellfun('isempty', tXmat(:,:)));
    tXmat(empty) = {NaN};
    tXmat = cell2mat(tXmat);
    
    tYmat = trax_Y;
    empty = find(cellfun('isempty', tYmat(:,:)));
    tYmat(empty) = {NaN};
    tYmat = cell2mat(tYmat);
    
    diffX = (abs(diff(tXmat))).^2;
    diffY = (abs(diff(tYmat))).^2;
    
    totdis = (diffX + diffY).^0.5;
    %figure
    %plot(totdis);
    
   
%% Remove Singles
for i = 1:size(track_set,2);
    trace = track_set{i};
    
    if size(trace,1) > framelimit;
        
    p1 = trace(1,:);
    p2 = trace(end,:) ;
    moving_traces{i} = trace;
    else
    moving_traces{i} = [];
    end
end

empty = find(~cellfun('isempty', moving_traces(:,:)));
moving_traces = moving_traces(empty);
%% Remove Short Lengths
%for k = 1:size(moving_traces,2)
 %   sys = moving_traces{k};
  %  p1 = sys(1,:);
   % p2 = sys(end,:);
   % sys_diff = (diff([p1;p2])).^2;
   % sys_diff = (sys_diff(1)+sys_diff(2)).^0.5;
   % if sys_diff < trav_thresh
    %    moving_traces{k} = [];
    %else
    %end
%end

empty = find(~cellfun('isempty', moving_traces(:,:)));
moving_traces = moving_traces(empty);

%% Remove Stationary Points
 points_out = cell(1,size(moving_traces,2));
for ii = 1:size(moving_traces,2);
    points = moving_traces{ii};
    d1 = (diff(points(:,2))).^2;
    d2 = (diff(points(:,2))).^2;
    fin_dis = (d1 + d2).^0.5;
    thresholder = find(fin_dis > dis_thresh);
    points_out{ii} = points(thresholder,:);
    point_distance(ii) = {fin_dis};
end

%final_pts = vertcat(points_out{:});
%figure
%hold on
%set(gca,'YDir','reverse');
%fill(X(1:4),Y(1:4),'b','FaceAlpha','0.1')
%fill(X(5:8),Y(5:8),'b','FaceAlpha','0.1')
%scatter(final_pts(:,1),final_pts(:,2),1,'Filled');

%% Remove Singles
for i = 1:size(points_out,2);
    trace = points_out{i};
    
    if size(trace,1) > 1;
        
    else
    points_out{i} = [];
    end
end

empty = find(~cellfun('isempty', points_out(:,:)));
points_out = points_out(empty);

final_pts = vertcat(points_out{:});
z1 = (sum(inpolygon(final_pts(:,1),final_pts(:,2),X(1:4),Y(1:4)))); 
z2 = (sum(inpolygon(final_pts(:,1),final_pts(:,2),X(5:8),Y(5:8))));
newPI = round((z2-z1)/(z2+z1),2);
end

