function [mode_model] = modeModelFcn(vid,numModFrames,maxTime)
%max time is in seconds (Nick)
tFrames = maxTime * vid.FrameRate;
frame_id = round(rand(1,30)*30);
frame_id = frame_id(frame_id>0);
im_rep = [];
for i = 1:length(frame_id)
%     frame_id = round(rand(1,1)*vid.Duration);
    get_im = rgb2gray(read(vid,frame_id(i)));
    im_rep(:,:,i) = (get_im);
    i
end

disp('Calculating Mode Background Model...')
mode_model = uint8(mode(im_rep,3));

disp('Background Model Complete')
