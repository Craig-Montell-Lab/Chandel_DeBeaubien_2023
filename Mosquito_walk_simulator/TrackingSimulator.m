%Number of Model Iterations
iterations = 10000;

%Number of Mosquito Intervals
interv = [1:10];
mcount = [21:30];
%Capture PIs
SimulationOutputPI = nan(iterations,max(interv));
SimulationOutputHSR = nan(iterations,max(interv));
%Define Zones
X = [98.88;564.69;564.69;101.46;701.46;1157.59;1156.95;701.46];
Y = [68.55;69.86;526.19;526.19;70.52;69.86;524.88;524.88];

%Jump Threshold
jump_threshold = 0.01

for kk = interv

%      No_Mosquitoes = interv(kk);
       No_Mosquitoes = mcount(kk)

        for k = 1:iterations
        runs_X = nan(3000,No_Mosquitoes);
        runs_Y = nan(3000,No_Mosquitoes);
        x0 = rand(1,No_Mosquitoes)*1280;
        y0 = rand(1,No_Mosquitoes)*720;
        runs_X(1,:) = x0;
        runs_Y(1,:) = y0;
        heading_x = zeros(1,No_Mosquitoes);
        heading_y = zeros(1,No_Mosquitoes);
            for ii = 2:3000
                jump_index = rand(1,No_Mosquitoes);
                jump_index = jump_index < jump_threshold;
                jump_x = rand(1,No_Mosquitoes)*1280;
                jump_y = rand(1,No_Mosquitoes)*720;
                runs_X(ii-1,jump_index) = jump_x(jump_index);
                runs_Y(ii-1,jump_index) = jump_y(jump_index);
                heading_x(jump_index) = 0;
                heading_y(jump_index) = 0;
                prev_X = runs_X(ii-1,:);
                prev_Y = runs_Y(ii-1,:);
               
                xstep = 2*rand(1,No_Mosquitoes)-1;
                ystep = 3*rand(1,No_Mosquitoes)-1.5;
             
                runs_X(ii,:) = prev_X+xstep+heading_x/1.1;
                runs_Y(ii,:) = prev_Y+ystep+heading_y/1.1;
               
                heading_x = runs_X(ii,:)-prev_X;
                heading_y = runs_Y(ii,:)-prev_Y;
            end
            all_x = nan(No_Mosquitoes*3000,1);
            all_y = nan(No_Mosquitoes*3000,1);
            ind_x = 1:3000;
            ind_y = 1:3000;
            
            for m = 1:No_Mosquitoes
        all_x(ind_x,1) = runs_X(:,m);
        all_y(ind_y,1) = runs_Y(:,m);
        ind_x = ind_x+3000;
        ind_y = ind_y+3000;
        alldat = [all_x,all_y];
        
            end
      
            
      
        step_size_x = diff(alldat(:,1));
        step_size_y = diff(alldat(:,2));
        step_size = (step_size_x.^2 + step_size_y.^2).^0.5;
        moving_index = step_size >= 0.5;
        moving_index = logical([1;moving_index]);
        alldat = alldat(moving_index,:);
        
        z1 = (sum(inpolygon(alldat(:,1),alldat(:,2),X(1:4),Y(1:4)))); 
        z2 = (sum(inpolygon(alldat(:,1),alldat(:,2),X(5:8),Y(5:8))));

        PI = (z2-z1)/(z2+z1);
        HSR = (z1+z2)/3000;
        SimulationOutputPI(k,kk) = PI;
        SimulationOutputHSR(k,kk) = HSR;
        k;
        
        if rem(k/100,1) == 0
            k
        else
        end
        
        end
           
end

  figure
        scatter(alldat(:,1),alldat(:,2),3,'Filled')
        xlim([1 1280])
        ylim([1 720])




% columnvals = NaN(iterations,30)
% finalPIs = cell2mat(SimulationOutput)
% for n = interv
%     columnvals(:,n) = n;
% end
% 
% figure
% for nn = interv
%     hold on
%     scatter(columnvals(:,nn),finalPIs(:,nn),50,'Filled',...
%         'MarkerFaceColor','b','MarkerFaceAlpha',0.05);
% end
% 
% boxplot(finalPIs)
% 
% runsx = [];
% runsy = [];
% 
% for i = 1:3000
% dx = runs{1,i}(:,1);
% dy = runs{1,i}(:,2);
% if i == 1;
% runsx = dx;
% runsy = dy;
% else
% runsx = [runsx,dx];
% runsy = [runsy,dy];
% end
% end
% 
% figure('Position',[500 500 1280 720])
% 
% for n = 1:max(interv)
% scatter(smooth(runsx(n,1:end-1)),smooth(runsy(n,1:end-1)),3,'Filled','MarkerFaceColor','b')
% hold on
% end
% set(gca,'TickDir','out')
% daspect([1 1 1])
% xlim([0 1280])
% ylim([0 720])
% 
% 
% 
% 
