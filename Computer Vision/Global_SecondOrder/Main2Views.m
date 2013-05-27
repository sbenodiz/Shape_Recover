%%% init
clear
 clc
close all
% 
% %%% run once
Doprint=0;

addpath('C:\Users\sbeno_000\Desktop\Saar\MATLAB\Computer Vision\Rozenfled');
addpath('C:\Users\sbeno_000\Desktop\Saar\MATLAB\Computer Vision\GetCorrespanse');
addpath('C:\Users\sbeno_000\Desktop\Saar\MATLAB\Computer Vision\GetPixelsVectors');
addpath('C:\Users\sbeno_000\Desktop\Saar\MATLAB\Computer Vision\Rozenfled\Get3DPoint');
addpath('C:\Users\sbeno_000\Desktop\Saar\MATLAB\Computer Vision\Rozenfled\TrasnformCoordinate');
addpath('C:\Users\sbeno_000\Desktop\Saar\MATLAB\Computer Vision\RecoverySurfaceMirror');
addpath('C:\Users\sbeno_000\Desktop\Saar\MATLAB\Computer Vision\Rozenfled');
addpath('C:\Users\sbeno_000\Desktop\Saar\MATLAB\Computer Vision\Global');
% 
%  load('K');
%  load('MapCorrespondencePixel');
%  load('3dPoints');
%  imageName='ball_12.4.13.avi';
%  moviAll = ReadAvi(imageName);
% % % % % % load('movi');
% % % % % % end init
% % % % 
%  imagesc(moviAll(350).cdata)
%  [choosenY,choosenX]=ginput(4);
%  choosenX=floor(choosenX);
%  choosenY=floor(choosenY);
% % end init
% 
% splitFrame=400;
% save('MirrorAndScreenLocation','choosenX','choosenY','splitFrame');
% load('MirrorAndScreenLocation');
% moviFirst=moviAll(1:splitFrame);
% moviSecond=moviAll(splitFrame+20:800);
% 
% 
% 
% 
% %%%get real surface eqution
% % % A=Points3DMirror(1,1:3);
% % % B=Points3DMirror(2,1:3);
% % % C=Points3DMirror(3,1:3);
% % % NormalToPlane=cross(B-A,C-A); %% calc the normal to plane
% % % % NormalToPlane=NormalToPlane/norm(NormalToPlane);  
% % % % 
% % % aReal=NormalToPlane(1);%%calc the real parameters of the plane that we search
% % % bReal=NormalToPlane(2);
% % % cReal=NormalToPlane(3);
% % % dReal=A*NormalToPlane';
% 
% %%%%
% 
% %%%%%%%%%%%%%%%%%
% % 
% % % 
% % % aGuess=aReal;
% % % bGuess=bReal;
% % % cGuess=cReal;
% % % dGuess=dReal;
% % % RealGuess=[aGuess,bGuess,cGuess,dGuess];
% 
% %%%%%%%%%
% if Doprint
%     figure, hold on
% end
% imagesc(moviAll(530).cdata)
% Margin=6;
% stepMirror=7;
% FirstPointmirror=[choosenX(3)+Margin,choosenY(3)+Margin];%%% the frame of the mirror (from selection of the user) we also can use motion process
% SecondPointmirror=[choosenX(4)-Margin,choosenY(4)-Margin];
% 
% count=0;
% for i=FirstPointmirror(1):stepMirror:SecondPointmirror(1)
%     for j=FirstPointmirror(2):stepMirror:SecondPointmirror(2)
%         count=count+1;
%       
%         pMiror1=[j,i,1];%%the first mirror point
%         
%         kNearest=3;
%         WindowSize=5;
%         IncludeIdentity=1;
%         NormalizeMinimumFounded=1;
%         %%% find correspanse pixel in the monitor
%         pScreen1=GetScreenPointAllPixel(pMiror1(1:2),MapCorrespondencePixel,kNearest);
%         pScreen1=round(pScreen1);
%         pScreen1=[pScreen1(1:2),1];
%         %%%%%%%
% 
%         
%         %%% find second points for the screen and the mirror points
%         [m,n,parameters]=GetNextPixel_parameters(moviSecond,pScreen1(2),pScreen1(1),WindowSize,IncludeIdentity,NormalizeMinimumFounded);
%         pScreen2 = getNextPointFromParameter( [m,n],parameters' );
%         pScreen2=fliplr(round(pScreen2));
%         pScreen2=[pScreen2(1:2),1];
% 
%         [m,n,parameters]=GetNextPixel_parameters(moviSecond,pMiror1(2),pMiror1(1),WindowSize,IncludeIdentity,NormalizeMinimumFounded);
%         pMiror2 = getNextPointFromParameter( [m,n],parameters' );
%         pMiror2=fliplr(round(pMiror2));
%         pMiror2=[pMiror2(1:2),1];
%         if Doprint
%             plotLine(pScreen1,pMiror1,'g')
%             plotLine(pMiror1,pMiror2,'r')
%             plotLine(pScreen1,pScreen2,'r')
%         end
%         
%         
%         AllData(count,:)=[pMiror1,pMiror2,pScreen1,pScreen2];
%         
%          %%%% find second points for the screen and the mirror points for
% %          %%%% the second movi 
%          count=count+1;
%         [m,n,parameters]=GetNextPixel_parameters(moviFirst,pScreen1(2),pScreen1(1),WindowSize,IncludeIdentity,NormalizeMinimumFounded);
%         pScreen2 = getNextPointFromParameter( [m,n],parameters' );
%         pScreen2=fliplr(round(pScreen2));
%         pScreen2=[pScreen2(1:2),1];
% 
%         [m,n,parameters]=GetNextPixel_parameters(moviFirst,pMiror1(2),pMiror1(1),WindowSize,IncludeIdentity,NormalizeMinimumFounded);
%         pMiror2 = getNextPointFromParameter( [m,n],parameters' );
%         pMiror2=fliplr(round(pMiror2));
%         pMiror2=[pMiror2(1:2),1];
%         
%         if Doprint
%             plotLine(pScreen1,pMiror1,'g')
%             plotLine(pMiror1,pMiror2,'r')
%             plotLine(pScreen1,pScreen2,'r')
%         end
% 
%         AllData(count,:)=[pMiror1,pMiror2,pScreen1,pScreen2];
%   
%         
%         
%     end
% end
% save('DataForOptimization_2Views');
load('DataForOptimization_2Views');
load('equation');
%   Guess=[ 1.5704    2.1079   15.5836];% x y z - center ball
% Guess=[0.0010    0.0010    0.0010         0         0         0  -0.0043    0.0006   -0.0352    1.2309];
%  Guess=[ 0    0   r];
options =optimset('Display', 'iter');
% Guess=[ 5.8969   -1.1804   25.9029];
Guess=[ 7.6235   -1.1983   32.8107 5.08];%best guess
% Guess=[ 1.0000    1.0000    1.0000         0         0  0   -8.1933    1.2301  -29.5456  915.7794];
%  Guess=[   0,0,0,0,0,0, -3.0936    3.0960    0.7701   60.4267];
%  Guess=[ -5   5 1  30];
Guess=[7.9943   -1.2308   32.1662    4.9552];
 
 tic
   [bestGuess]=fminsearch(@(args) CheckParametersSecondOrder(args,AllData,K,Points3DScreen,equation),Guess,options);
toc
  [sumError,numOfPoints] =CheckParametersSecondOrder(bestGuess,AllData,K,Points3DScreen,equation)

 save('bestGuess','bestGuess')
x1=bestGuess(1);
y1=bestGuess(2);
z1=bestGuess(3);
r=5.08;
 r=bestGuess(4);
 args=[1,1,1,0,0,0,-x1,-y1,-z1,x1^2+y1^2+z1^2-r^2];
% args=bestGuess;
% args=[args(1),args(2),args(3),0,0,0,args(4),args(5),args(6),args(7)];


figure, hold on

plot3(Points3DScreen(:,1),Points3DScreen(:,2),Points3DScreen(:,3));
for i=1:4
    drawBubble(Points3DScreen(i,1),Points3DScreen(i,2),Points3DScreen(i,3),1,'g',int2str(i),'r',0)
end

DrawEllipticParaboloid( args,FirstPointmirror,SecondPointmirror,K ,equation)
%  DrawPlane(bestGuess,FirstPointmirror,SecondPointmirror,K,'g');


