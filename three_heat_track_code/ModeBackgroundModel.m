frame_id = round(rand(1,100)*v.NumFrames);
frame_id = frame_id(frame_id>0);
% im_rep = [];
v.CurrentTime = 0;
im_rep = [];
disp('Generating Background Model...')
for i = 1:length(frame_id)
%     frame_id = round(rand(1,1)*vid.Duration);
    get_im = rgb2gray(read(v,frame_id(i)));
%     get_im = im2gray(readFrame(vid));
    im_rep(:,:,i) = (get_im);
    
end


mode_model = uint8(mode(im_rep,3));

disp('Background Model Complete')

%clearvars -except v imscale starttime endtime minflysize maxflysize rot_col mode_model Experiment_Info ProtoFly ProtoFlyMaskLength xRange yRange vid

