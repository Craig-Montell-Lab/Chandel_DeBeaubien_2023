frame_id = round(rand(1,100)*vid.NumFrames);
frame_id = frame_id(frame_id>0);
% im_rep = [];
vid.CurrentTime = 0;

for i = 1:length(frame_id)
%     frame_id = round(rand(1,1)*vid.Duration);
    get_im = rgb2gray(read(vid,frame_id(i)));
%     get_im = im2gray(readFrame(vid));
    im_rep(:,:,i) = (get_im);
    i
end

disp('Calculating Mode Background Model...')

mode_model = double(mode(im_rep,3));
std_mode = std(double(im_rep),[],3);
Thresh_img = std_mode.*3 + mode_model;
Thresh_img = uint8(Thresh_img);

disp('Background Model Complete')

%clearvars -except v imscale starttime endtime minflysize maxflysize rot_col mode_model Experiment_Info ProtoFly ProtoFlyMaskLength xRange yRange vid

