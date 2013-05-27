    
clc
clear all
close all
tic
imageName='FromImage_flat4.avi';

h = waitbar(0,'Running......');
mov = (ReadAvi(imageName));clc
movi = mov;
MaxValue=1;
if (strcmp(imageName,'FromImage4.avi'))
    thresholdRound=5;
    thresholdGlobal=75;
elseif (strcmp(imageName,'FromImage6.avi'))
    thresholdGlobal=70;
    thresholdRound=4;
elseif (strcmp(imageName,'FromImage_flat.avi'))
    thresholdGlobal=40;
    thresholdRound=8;
elseif (strcmp(imageName,'FromImage_flat2.avi'))
    thresholdGlobal=40;
    thresholdRound=8;
elseif (strcmp(imageName,'FromImage_flat3.avi'))
    thresholdGlobal=50;
    thresholdRound=8;
elseif (strcmp(imageName,'FromImage_flat4.avi'))
    thresholdGlobal=50;
    thresholdRound=8;
end



clear mov;
diffI=zeros(size(movi(1).cdata(:,:,1)));
for i = 2:length(movi)
    movc = movi(i).cdata;
    waitbar(i/length(movi),h);
    movp = movi(i-1).cdata;
    u = motion(movc,movp);
    temp2DImage=abs(u(:,:,1)+u(:,:,2)+u(:,:,3));
    temp2DImage=thresholdFunc(temp2DImage,thresholdRound,MaxValue);
    diffI= diffI+double(temp2DImage);

end

 hist(diffI(:))

 diffI=thresholdFunc(diffI,thresholdGlobal,255);




figure(1),imshow((diffI));


%remove small objects
newImage=bwareaopen(diffI,350, 8);
figure(2),imshow((newImage));




newImage=bwmorph(newImage,'majority',Inf);
figure(3),imshow((newImage));

newImage=bwmorph(newImage,'close',Inf);
figure(4),imshow((newImage));
newImage=bwmorph(newImage,'open',Inf);
figure(5),imshow((newImage));






diffI=newImage;
 
 xs=diffI(:,:)>0.5;
 for i = 1:length(movi)
    movi(i).cdata(xs)=255;
 
 end
 implay(movi);
 figure(6),imshow(movi(1).cdata);
 
 
 
toc