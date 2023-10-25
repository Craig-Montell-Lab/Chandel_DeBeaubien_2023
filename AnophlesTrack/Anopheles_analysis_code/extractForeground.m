function dframe = extractForeground(frame,arenaModel,Thresh)
gFrame = im2gray(frame);
dframe = imabsdiff(arenaModel,gFrame);
dframe(dframe>Thresh) = 255;
dframe(dframe<Thresh) = 0;
dframe = imerode(dframe,strel('rectangle',[2 2]));
%dframe = imdilate(dframe,strel('rectangle',[4 4]));

%dframe = imdilate(dframe,strel('disk',4));
dframe = imfill(dframe,'holes');
dframe = logical(dframe);
end