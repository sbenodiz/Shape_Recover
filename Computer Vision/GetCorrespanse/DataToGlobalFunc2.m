j=523; %index in MapAllPixel
pMiror1=[178,618];%mirror first pixel 
% pMiror2=[183,627];%mirror second point
pMiror1=fliplr(pMiror1);
% pMiror2=fliplr(pMiror2);


% load('data');
% load('MapCorrespondencePixel');
kNearest=3;
% pScreen1=GetScreenPointAllPixel(pMiror1,MapCorrespondencePixel,kNearest);
pScreen1=[426.923076923077,144.384615384615;];





% pScreen1=[420,145];

imageName='FromImage_flat4.avi';
WindowSize=10;
step=10;
IncludeIdentity=1;
NormalizeMinimumFounded=1;
movi = ReadAvi(imageName);
% 
[m,n,parameters]=GetNextPixel_parameters(movi,pScreen1(1),pScreen1(2),WindowSize,IncludeIdentity,NormalizeMinimumFounded);
pScreen2 = getNextPointFromParameter( [m,n],parameters' );
 
 
 
 
% 
% 
% pScreen1=fliplr(pScreen1);
% pScreen2=fliplr(pScreen2);
% pMiror1=fliplr(pMiror1);
% pMiror2=fliplr(pMiror2);
% figure;
% imagesc(movi(1).cdata);
% hold on
% plot([pScreen1(2),pScreen2(2)],[pScreen1(1),pScreen2(1)],'Color','r','LineWidth',4)
% plot([pMiror1(2),pMiror2(2)],[pMiror1(1),pMiror2(1)],'Color','r','LineWidth',4)
% 
% 
% 
