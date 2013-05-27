j=523; %index in MapAllPixel
pMiror1=[618,178,1];%mirror first pixel 
pMiror2=[624,180,1];%mirror second point
% pMiror1=fliplr(pMiror1);
% pMiror2=fliplr(pMiror2);

load('K');
% load('data');
% load('MapCorrespondencePixel');
% kNearest=3;
% pScreen1=GetScreenPointAllPixel(pMiror1,MapCorrespondencePixel,kNearest);
pScreen1=[427,144,1];
pScreen2=[421,144,1];

pScreen3D1=Get3DPoint(Points3DScreen,pScreen1,K);
pScreen3D2=Get3DPoint(Points3DScreen,pScreen2,K);

pMiror3D1=Get3DPoint(Points3DMirror,pMiror1,K);
pMiror3D2=Get3DPoint(Points3DMirror,pMiror2,K);


pScreen3D1=[7.52733524310819,-11.2609024548885,46.8124637304898;];
pScreen3D2=[6.79078906372367,-11.1671514450284,46.4227333544074;];
pMiror3D1=[26.5739837547577,-6.95731501645962,42.6620951230083;];
pMiror3D2=[27.3308379710270,-6.79710359208973,42.8779146991716;];