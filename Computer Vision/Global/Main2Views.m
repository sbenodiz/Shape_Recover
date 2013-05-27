%%% init
clear
 clc
close all
% 
% %%% run once
addpath('C:\Users\SAAR\MATLAB\Computer Vision\Rozenfled');
addpath('C:\Users\SAAR\MATLAB\Computer Vision\GetCorrespanse');
addpath('C:\Users\SAAR\MATLAB\Computer Vision\GetPixelsVectors');
addpath('C:\Users\SAAR\MATLAB\Computer Vision\Rozenfled\Get3DPoint');
addpath('C:\Users\SAAR\MATLAB\Computer Vision\Rozenfled\TrasnformCoordinate');
load('K');
load('MapCorrespondencePixel');
load('MirrorAndScreenLocation');
load('3dPoints');
imageName='Flat3.2.12.avi';
moviAll = ReadAvi(imageName);
% load('movi');
% movi=movi(1:100); % just for perfomnce
%%% end init
% % 
%  imagesc(moviAll(1).cdata)
%  [choosenY,choosenX]=ginput(4);
%  choosenX=floor(choosenX);
%  choosenY=floor(choosenY);
%  moviFirst=moviAll;
%  save('MirrorAndScreenLocation','choosenX','choosenY');
% end init
% splitFrame=380;
% moviFirst=moviAll(1:splitFrame);
% moviSecond=moviAll(splitFrame:700);


% 
% 
% %%%get real surface eqution
A=Points3DMirror(1,1:3);
B=Points3DMirror(2,1:3);
C=Points3DMirror(3,1:3);
NormalToPlane=cross(B-A,C-A); %% calc the normal to plane
% NormalToPlane=NormalToPlane/norm(NormalToPlane);  
% 
aReal=NormalToPlane(1);%%calc the real parameters of the plane that we search
bReal=NormalToPlane(2);
cReal=NormalToPlane(3);
dReal=A*NormalToPlane';

%%%%%

%%%%%%%%%%%%%%%%%%


aGuess=aReal;
bGuess=bReal;
cGuess=cReal;
dGuess=dReal;
RealGuess=[aGuess,bGuess,cGuess,dGuess];
% Guess=[0 0 30];
% bestGuess=[[0.999966453457000,0.00818668669886194,26.2126474741492;]];
% %%%%%%%%%
 %%%%%%bestGuess=[-52.4419    0.6237   36.3080   44.5713];



Margin=20;
stepMirror=5;

FirstPointmirror=[choosenX(3)+Margin,choosenY(3)+Margin];%%% the frame of the mirror (from selection of the user) we also can use motion process
SecondPointmirror=[choosenX(4)-Margin,choosenY(4)-Margin];

count=0;
for i=FirstPointmirror(1):stepMirror:SecondPointmirror(1)
    for j=FirstPointmirror(2):stepMirror:SecondPointmirror(2)
        count=count+1;
        pMiror1=[j,i,1];%%the first mirror point
        
        kNearest=3;
        WindowSize=10;
        IncludeIdentity=1;
        NormalizeMinimumFounded=1;
        %%%% find correspanse pixel in the monitor
        pScreen1=GetScreenPointAllPixel(pMiror1(1:2),MapCorrespondencePixel,kNearest);
        pScreen1=round(pScreen1);
        pScreen1=[pScreen1(1:2),1];
        %%%%%%%%

        
        
        
        
        %%%% find second points for the screen and the mirror points
        [m,n,parameters]=GetNextPixel_parameters(moviFirst,pScreen1(2),pScreen1(1),WindowSize,IncludeIdentity,NormalizeMinimumFounded);
        pScreen2 = getNextPointFromParameter( [m,n],parameters' );
        pScreen2=fliplr(round(pScreen2));
        pScreen2=[pScreen2(1:2),1];

        [m,n,parameters]=GetNextPixel_parameters(moviFirst,pMiror1(2),pMiror1(1),WindowSize,IncludeIdentity,NormalizeMinimumFounded);
        pMiror2 = getNextPointFromParameter( [m,n],parameters' );
        pMiror2=fliplr(round(pMiror2));
        pMiror2=[pMiror2(1:2),1];
        
        
        
        AllData(count,:)=[pMiror1,pMiror2,pScreen1,pScreen2];
        
         %%%% find second points for the screen and the mirror points for
         %%%% the second movi 
%          count=count+1;
%         [m,n,parameters]=GetNextPixel_parameters(moviSecond,pScreen1(2),pScreen1(1),WindowSize,IncludeIdentity,NormalizeMinimumFounded);
%         pScreen2 = getNextPointFromParameter( [m,n],parameters' );
%         pScreen2=fliplr(round(pScreen2));
%         pScreen2=[pScreen2(1:2),1];
% 
%         [m,n,parameters]=GetNextPixel_parameters(moviSecond,pMiror1(2),pMiror1(1),WindowSize,IncludeIdentity,NormalizeMinimumFounded);
%         pMiror2 = getNextPointFromParameter( [m,n],parameters' );
%         pMiror2=fliplr(round(pMiror2));
%         pMiror2=[pMiror2(1:2),1];
%         
%         
%         
%         AllData(count,:)=[pMiror1,pMiror2,pScreen1,pScreen2];
  
        
        
    end
end
save('DataForOptimization_2Views');
load('DataForOptimization_2Views');

%%%% run once


tic
  [bestGuess]=fminsearch(@(args) CheckParameters(args,AllData,K,Points3DScreen,A),RealGuess);

  [sumError,numOfPoints] =CheckParameters(RealGuess,AllData,K,Points3DScreen,A)
  [sumError,numOfPoints] =CheckParameters(bestGuess,AllData,K,Points3DScreen,A)

toc



figure, hold on
 DrawPlane(bestGuess,FirstPointmirror,SecondPointmirror,K,'g',A);
 DrawPlane(RealGuess,FirstPointmirror,SecondPointmirror,K,'r',A);
plot3(Points3DMirror(:,1),Points3DMirror(:,2),Points3DMirror(:,3));
for i=1:4
    drawBubble(Points3DMirror(i,1),Points3DMirror(i,2),Points3DMirror(i,3),1,'g',int2str(i),'b',0)
end
plot3(Points3DScreen(:,1),Points3DScreen(:,2),Points3DScreen(:,3));
for i=1:4
    drawBubble(Points3DScreen(i,1),Points3DScreen(i,2),Points3DScreen(i,3),1,'g',int2str(i),'r',0)
end

% DrawPlane(argsGuessNotNormal,[FirstPointmirror(2),FirstPointmirror(1),1],K,'b');
% % CheckPoint(movi, MapCorrespondencePixel,pMiror1,a,b,c,s)
