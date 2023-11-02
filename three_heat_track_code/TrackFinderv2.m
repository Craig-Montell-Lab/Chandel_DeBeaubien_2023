function [trax_X,trax_Y,track_data, track_set] = TrackFinderv2(X,Y,cords,FR, speed)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

remove_blanks = ~cellfun('isempty',cords(:,:));
cords = cords(remove_blanks);

    for i = 1:length(cords)
        big(i) = length(cords{i});
    end

wind = round(max(big)*5);


%Print first row of data
trax_X = cell(round(length(cords)),wind);
trax_Y = cell(round(length(cords)),wind);

track_set = cell(1,length(cords));
set = [cords{1}];

    for ii = 1:size(set,1)
        trax_X{1,ii} = set(ii,1);
        trax_Y{1,ii} = set(ii,2); 
    end

%tic
%f = waitbar(0,'0','Name','Calculating Mosquito Tracks');
tick = 1;

        for k = 1:length(cords)-1
            
            query = cords{k+1};  

                %if ~isempty(query) && ~isempty([[trax_X{k,:}]',[trax_Y{k,:}]'])
                [findspot,distance] = knnsearch(query,[[trax_X{k,:}]',[trax_Y{k,:}]']);  
                limiter = distance < speed;    
                findspot = findspot(limiter);    
                query_list = [1:length([trax_X{k,:}])];
                query_list = query_list(limiter);
                Xplaces = cell(1, wind);
                Yplaces = cell(1, wind);

                        for i = 1:length(findspot)
                        Xplaces{query_list(i)} = query(findspot(i),1);
                        Yplaces{query_list(i)} = query(findspot(i),2);
                        end        

                trax_X(k+1,:) = Xplaces;
                trax_Y(k+1,:) = Yplaces;
                edge1 = find(~cellfun('isempty', trax_X(k,:)), 1, 'last' )+1;
                edge2 = find(~cellfun('isempty', trax_X(k+1,:)), 1, 'last' )+1;
                edge = max([edge1 edge2]);
                remover = [find(limiter == 0)];
                used_X = [trax_X{k+1,:}]';
                remaining = find(~ismember(query(:,1),used_X));
                unassigned = [query(remaining,:)];   
                added = length(unassigned(:,1));  

                        for u = 1:length(unassigned(:,1))
                            trax_X{k+1,edge+u-1} = unassigned(u,1);
                            trax_Y{k+1,edge+u-1} = unassigned(u,2);
                        end

                        for i = 1:length(remover)
                            track_set{tick} = [ [trax_X{:,remover(i)}]',[trax_Y{:,remover(i)}]'];
                            tick = tick+1;    
                        end    

                trax_X(:,remover) = [];
                trax_Y(:,remover) = [];
                trax_X{1,wind} = [];
                trax_Y{1,wind} = [];        
                %percent = k/(length(cords)-1);
                %waitbar(percent,f,sprintf('%3.1f%%',percent*100));

                %else
                    %'skip'
                %end
                
        end
 
    for ii = 1:length(wind)
        track_set{tick} = [ [trax_X{:,ii}]',[trax_Y{:,ii}]'];
        tick = tick+1;
    end

%close(f)
%toc
empty = ~cellfun('isempty', track_set(:,:));
track_set = track_set(empty);

 
 
%figure
%hold on
%axis ij
%    fill(X(1:4),Y(1:4),'b','FaceAlpha','0.1')
%    fill(X(5:8),Y(5:8),'b','FaceAlpha','0.1')
%daspect([1 1 1])
    
%colormap(parula)
%for i = 1:size(track_set,2)
%traj = track_set{i};
%plot(traj(:,1),traj(:,2));

%end


X_dat = NaN(length(trax_X),size(track_set,2));
Y_dat = NaN(length(trax_X),size(track_set,2));
Dif_dat = NaN(length(trax_X),size(track_set,2));

for i = 1:size(track_set,2)
    XY = track_set{i};
    X_dat(1:length(XY),i) = XY(:,1);
    Y_dat(1:length(XY),i) = XY(:,2);
    Dif_dat(2:length(XY),i) =  sqrt(sum(abs(diff(XY)),2));
end



dis1 = nansum(Dif_dat(inpolygon(X_dat,Y_dat,X(1:4),Y(1:4))));
dis2 = nansum(Dif_dat(inpolygon(X_dat,Y_dat,X(5:8),Y(5:8))));

tim1 = (sum(nansum((inpolygon(X_dat,Y_dat,X(1:4),Y(1:4))))))/FR; 
tim2 = (sum(nansum((inpolygon(X_dat,Y_dat,X(5:8),Y(5:8))))))/FR;

meantime1 = (mean(nonzeros(nansum((inpolygon(X_dat,Y_dat,X(1:4),Y(1:4)))))))/FR;
meantime2 = (mean(nonzeros(nansum((inpolygon(X_dat,Y_dat,X(5:8),Y(5:8)))))))/FR;

track_data = cell({'Total Distance Zone 1','Total Distance Zone 2','Total Time Zone 1',...
    'Total Time Zone 2','Average Time Zone 1', 'Average Time Zone 2';dis1,dis2,tim1,...
    tim2,meantime1,meantime2});

end

