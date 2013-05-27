j=523; %index in MapAllPixel
        
pMiror2=[627,183];%mirror second point



% load('data');
% load('MapCorrespondencePixel');
kNearest=3;
%this funcrion get input like (y,x)  so filp the input
%pScreen1=GetScreenPointAllPixel(pMiror1,MapCorrespondencePixel,kNearest);

pScreen1=[425,145];
pScreen2=[419.45,145];


imageName='FromImage_flat4.avi';
WindowSize=10;
IncludeIdentity=1;
NormalizeMinimumFounded=1;
movi = ReadAvi(imageName);

[m,n,parameters]=GetNextPixel_parameters(movi,pScreen1(2),pScreen1(1),WindowSize,IncludeIdentity,NormalizeMinimumFounded);
pScreen2 = getNextPointFromParameter( [m,n],parameters' );


pScreen2=fliplr(pScreen2);
figure;
imagesc(movi(1).cdata);
hold on
plot([pScreen1(1),pScreen2(1)],[pScreen1(2),pScreen2(2)],'Color','r','LineWidth',2)
plot([pMiror1(1),pMiror2(1)],[pMiror1(2),pMiror2(2)],'Color','r','LineWidth',2)
pScreen3D1=[7.28043403983420,-11.1230826025629,46.6817289312512;];
pMirror1=[26.9514685951886,-6.68250035037090,42.7697525096091;];


pScreen3D1=[7.28043403983420,-11.1230826025629,46.6817289312512;];
pScreen3D2=[6.60248970343240,-11.0376082751419,46.3230073856316;];

pMiror3D1=[26.9514685951886,-6.68250035037090,42.7697525096091;];
pMiror3D2=[27.7121568809062,-6.52048882144754,42.9866654664424;];

