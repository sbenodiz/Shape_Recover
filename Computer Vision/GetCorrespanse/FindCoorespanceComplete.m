 clc;
 clear all
 close all
% ;
  imageName='ball_12.4.13.avi';
 [ScreenPoints,MirrorPoints,image]=SplitVideo(imageName);
% % % 
 save('data')
load('data');
mirrorName='mirrormovie.avi';
screenName='screenmovie.avi';
numberOfFrames=300;
TreshHold=10;
TreshHoldErr=0.22;
WindowsSize=5;
% 
mirrorMovie = (ReadAvi(mirrorName));
screenMovie = (ReadAvi(screenName));
% 
MapCorrespondencePixelNew=GetCoorespancePoint( numberOfFrames,TreshHold,TreshHoldErr,WindowsSize,mirrorMovie,screenMovie,MirrorPoints,ScreenPoints );
% 
%  save('data');
%   load('data');


  
  
figure;
imagesc(image); hold on;
numberOfPoints=size(MapCorrespondencePixelNew,1)
for i=1:numberOfPoints
      c=rand(1,3);
%       plot([MapCorrespondencePixel(i,1)+ScreenPoints(2) MirrorPoints(2)-(MapCorrespondencePixel(i,3)+MirrorPoints(2))+MirrorPoints(4)],[MapCorrespondencePixel(i,2)+ScreenPoints(1) MapCorrespondencePixel(i,4)+MirrorPoints(1)],'-','Color',c)
      plot([MapCorrespondencePixelNew(i,1) MapCorrespondencePixelNew(i,3)],[MapCorrespondencePixelNew(i,2) MapCorrespondencePixelNew(i,4)],'-','Color',c)

end
MapCorrespondencePixel=MapCorrespondencePixelNew;
% 
% figure;
% imagesc(image); hold on;
% numberOfPoints=size(MapCorrespondencePixel,1)
% for i=1:numberOfPoints
%       c=rand(1,3);
% %       plot([MapCorrespondencePixel(i,1)+ScreenPoints(2) MirrorPoints(2)-(MapCorrespondencePixel(i,3)+MirrorPoints(2))+MirrorPoints(4)],[MapCorrespondencePixel(i,2)+ScreenPoints(1) MapCorrespondencePixel(i,4)+MirrorPoints(1)],'-','Color',c)
%       plot([MapCorrespondencePixel(i,1) MapCorrespondencePixel(i,3)],[MapCorrespondencePixel(i,2) MapCorrespondencePixel(i,4)],'-','Color',c)
% 
% end

 save('MapCorrespondencePixel','MapCorrespondencePixel');
 
    