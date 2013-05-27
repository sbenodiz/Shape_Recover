j=523; %index in MapAllPixel
pMiror1=[178,618];%mirror first pixel 
pMiror2=[180,624];%mirror second point
% pMiror1=fliplr(pMiror1);
% pMiror2=fliplr(pMiror2);

load('K');
% load('data');
% load('MapCorrespondencePixel');
% kNearest=3;
% pScreen1=GetScreenPointAllPixel(pMiror1,MapCorrespondencePixel,kNearest);
pScreen1=[144,427];
pScreen2=[144,421];

pScreen3D1=Get3DPoint(Points3DScreen,pScreen1,K);
pScreen3D2=Get3DPoint(Points3DScreen,pScreen2,K);

pMiror3D1=Get3DPoint(Points3DMirror,pMiror1,K);
pMiror3D2=Get3DPoint(Points3DMirror,pMiror2,K);
