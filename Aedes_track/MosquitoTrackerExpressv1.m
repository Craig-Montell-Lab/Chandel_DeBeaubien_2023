%% TRACKING PARAMETERS 

clearvars -except X Y ExpList OutList ExpName OutName ReferenceList ZoneMaster Range;
sizes = [140 320];

erode = 2;
sens = 0.29;
%sens = 0.4
fsize = 0.5;

framelimit = 4;

FR = 10;



file_name = ExpName;
output = OutName;
v = VideoReader(file_name);
%FR = v.FrameRate
mkdir(output);
addpath(genpath(output));
    

%% SET TIME FOR ANALYSIS
    TotalTime = num2str(round(v.Duration));

    start_time = 0;
    end_time = 300;
    %end_time = 120;
    period = end_time*FR - start_time*FR;
    Final = period;


    v.CurrentTime = 0;   

   
%% ZONE LABELS

findbox = readFrame(v);
% zone1text = '';
% zone2text = ''; 
 
%%                 


    nFrames = ceil(v.FrameRate*v.Duration);

       

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
for k = 1:Final

        im = readFrame(v);                                                  % Reads video frame
        im = rgb2gray(im);
       
        [BW] = segmentImage5v1(im,erode,sens);  

        radius = 2;
decomposition = 0;
se = strel('disk', radius, decomposition);
BW = imerode(BW, se);
        BW_inv = ((BW-1)*-1) == 1;                                          % Invert threshold image
        % imshow(BW_inv)
       
        
        blobs = regionprops(BW_inv);
        

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
        
%% Data Visualization
%Concatenate all coordinates
        all_cords = vertcat(cords{:});
     

%Plot Mosquito Positions
        %tracks = figure('Position',[100 100 v.Width v.Height]);
        %set(gca,'YDir','reverse');
        %daspect([1 1 1])
        %hold on;
        %fill(X(1:4),Y(1:4),'b','FaceALpha',0.1);
        %fill(X(5:8),Y(5:8),'b','FaceALpha',0.1);
        %scatter(all_cords(:,1),all_cords(:,2),5,'Filled');


        bin_size = 100;


%% Perform Track Analysis


                speed = 10; 
               [trax_X,trax_Y,track_data,track_set] = TrackFinderv2(X,Y,cords,FR, speed);





%% Remove Stationary Mosquitoes

               [newPI, final_pts, point_distance] = stat_remover(track_set,trax_X,trax_Y,X,Y,fsize,framelimit);



%% Output File Handling

round(size(final_pts,1)/(end_time*FR),2);
SeekingScore = round(size(final_pts,1)/(end_time*FR),2);
[newPI, SeekingScore]

outfile = strcat(output, '.mat');
outpath = strcat(pwd,'/',output,'/',outfile);
%close(tracks);
save(outpath);



close all
