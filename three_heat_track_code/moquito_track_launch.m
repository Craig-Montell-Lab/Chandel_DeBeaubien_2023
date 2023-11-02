%Geoff launch
masterTable = table()
%% file handling 
for fileIdx = 1:length(Params.FilePath)
file_name = Params.FilePath{fileIdx};
sizes = [20 250];
%[sect] = border_exclusion(X,Y);
erode = 4;
sens = 0.29;
%sens = 0.4
fsize = 0.5;

framelimit = 4;


v = VideoReader(file_name);
FR = 10;

%% SET TIME FOR ANALYSIS
    TotalTime = num2str(round(v.Duration));

    start_time = 0;
    end_time = 300;
    %end_time = 120;
    period = end_time*FR - start_time*FR;
    Final = period;


    v.CurrentTime = 0;   

%%                 


    nFrames = ceil(v.FrameRate*v.Duration);

        
    ModeBackgroundModel

%% Data Analysis

%Resets video to first frame
    v.CurrentTime = start_time;                                           

%Preallocate Data
    cords = cell(1,nFrames);
%Generates Progress Bar for Loop

    
% Preallocate Data    
allBlobAreas = NaN(1,80);
allowableAreaIndexes = NaN(1,80);
keeperIndexes = NaN(1,80);
dots = NaN(80,2);
disp("Getting blobs for video" + " " + num2str(fileIdx))
for k = 1:Final

        im = im2gray(readFrame(v));                                                  % Reads video frame
        im_diff = imabsdiff(im,mode_model);
        %im(sect) = 200;
        % Converts RGB frame to grayscale
        %[BW] = segmentImage5v1(im,erode,sens);    
        % [BW] = segmentImage5v1(im,erode,sens);  
        BW = im_diff > 30;
        radius = 1;
        decomposition = 0;
        se = strel('disk', radius, decomposition);
        BW = imdilate(BW, se);
        %imshowpair(BW,im)
       
        
        blobs = regionprops(BW);
        

        allBlobAreas = [blobs.Area];
        allowableAreaIndexes = (allBlobAreas > sizes(1)) & (allBlobAreas < sizes(2));
        keeperIndexes = find(allowableAreaIndexes);
        

        
        dots = vertcat(blobs.Centroid);
        dots = dots(keeperIndexes,:);
        cords(k) = {dots};
        

allBlobAreas = NaN(1,80);
allowableAreaIndexes = NaN(1,80);
keeperIndexes = NaN(1,80);
dots = NaN(80,2);       

    
end

        cords(k+1:end) = [];
        
% %% Data Visualization
% %Concatenate all coordinates
%         all_cords = vertcat(cords{:});
%         
% 
%         %%Plot Mosquito Positions
%         tracks = figure('Position',[100 100 v.Width v.Height]);
%         set(gca,'YDir','reverse');
%         daspect([1 1 1])
%         hold on;
%         fill(X(1:4),Y(1:4),'b','FaceALpha',0.1);
%         fill(X(5:8),Y(5:8),'b','FaceALpha',0.1);
%         scatter(all_cords(:,1),all_cords(:,2),5,'Filled');


        bin_size = 100;


%% Perform Track Analysis

                X = [Params.Zones{fileIdx,1}(:,1);Params.Zones{fileIdx,2}(:,1)];
                Y = [Params.Zones{fileIdx,1}(:,2);Params.Zones{fileIdx,2}(:,2)];

                speed = 10;
                disp("Finding tracks for video " + num2str(fileIdx))
               [trax_X,trax_Y,track_data,track_set] = TrackFinderv2(X,Y,cords,FR, speed);





%% Remove Stationary Mosquitoes

               [newPI, final_pts, point_distance] = stat_remover(track_set,trax_X,trax_Y,X,Y,fsize,framelimit);



%% Output File Handling

round(size(final_pts,1)/(end_time*FR),2)
SeekingScore = round(size(final_pts,1)/(end_time*FR),2);
[newPI, SeekingScore]
%% save raw data  
Data = struct();
Data.PI = newPI;
Data.SeekingScore = SeekingScore
Data.point_distance=point_distance
Data.track_data = track_data
Data.track_set = track_set
%% grow data table 
miniTable = table()
miniTable.File = Params.FilePath(fileIdx)
miniTable.SeekingScore = SeekingScore;
miniTable.PI = newPI
miniTable.Zone1_Time = track_data{2,3}
miniTable.Zone2_Time = track_data{2,4}

masterTable = [masterTable;miniTable];
%% save data 
sName = file_name+".mat";
save(sName,"Data");
%%
clearvars -except fileIdx masterTable Params
end
% outfile = strcat(output, '.mat');
% outpath = strcat(pwd,'/',output,'/',outfile);
% %close(tracks);
% save(outpath);
% 


close all





    
