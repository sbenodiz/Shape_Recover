close all
clear
clc

addpath('C:\Users\SAAR\MATLAB\Computer Vision\Rozenfled');

addpath('C:\Users\SAAR\MATLAB\Computer Vision\Global');
addpath('C:\Users\SAAR\MATLAB\Computer Vision\Rozenfled\TrasnformCoordinate');
addpath('C:\Users\SAAR\MATLAB\Computer Vision\RecoverySurfaceMirror');
addpath('C:\Users\SAAR\MATLAB\Computer Vision\Simulation')
addpath('C:\Users\SAAR\MATLAB\Computer Vision\Rozenfled');
load('movi');
load('3dPoints');
load('k');
load('MirrorAndScreenLocation');

Points3DImageSurface(1,1:3)=[-10,-10,1];
Points3DImageSurface(2,1:3)=[10,-10,1];
Points3DImageSurface(3,1:3)=[10,10,1];
Points3DImageSurface(4,1:3)=[-10,10,1];
Points3DImageSurface(5,1:3)=[-10,-10,1];

%%%%%calc the normal to mirror -urface
AScreen=Points3DScreen(1,1:3);
BScreen=Points3DScreen(2,1:3);
CScreen=Points3DScreen(4,1:3);
NormalToPlaneScreen=cross(BScreen-AScreen,CScreen-AScreen);
NScreen=NormalToPlaneScreen/norm(NormalToPlaneScreen);
aRealScreen=NScreen(1);
bRealScreen=NScreen(2);
cRealScreen=NScreen(3);
dRealScreen=AScreen*NScreen';

%get the coordinate system of the monitor in the coordinate system of the
%camera

om_i=Points3DScreen(1,1:3);
Xm_i=Points3DScreen(4,1:3)-om_i;
Ym_i=Points3DScreen(2,1:3)-om_i;
Zm_i=cross(Xm_i,Ym_i);
Xm_i=Xm_i/norm(Xm_i);
Ym_i=Ym_i/norm(Ym_i);
Zm_i=Zm_i/norm(Zm_i);
%%%%%%%%%%%%%%%%%%%%
%%%camaera cooediante system
oi=[0 0 0];
Xi=[1 0 0];
Yi=[0 1 0];
Zi=[0 0 1];
Axis_i=[Xi;Yi;Zi];

Axis_i=Axis_i+[oi;oi;oi];
Axis_i(4,1:3)=oi ;

Axis_m=[Xm_i;Ym_i;Zm_i];
Axis_m=Axis_m+[om_i;om_i;om_i];
Axis_m(4,1:3)=om_i;


[R_m_i,T_m_i,Yf,Err] = rot3dfit(Axis_i,Axis_m);

%%%%%calc the normal to mirror -surface
A=Points3DMirror(1,1:3);
B=Points3DMirror(2,1:3);
C=Points3DMirror(4,1:3);
NormalToPlane=cross(B-A,C-A);
N=NormalToPlane/norm(NormalToPlane);
aReal=N(1);
bReal=N(2);
cReal=N(3);
dReal=A*N';

%%%%%%%%%%%%calc Fake O
[I,check]=plane_line_intersect(N,A,[0,0,0],N);
fakeO=I+I;


[I,check]=plane_line_intersect(N,A,Points3DImageSurface(1,1:3),Points3DImageSurface(1,1:3)+N);
Points3DImageSurfaceFake(1,1:3)=2*I -Points3DImageSurface(1,1:3);

[I,check]=plane_line_intersect(N,A,Points3DImageSurface(2,1:3),Points3DImageSurface(2,1:3)+N);
Points3DImageSurfaceFake(2,1:3)=2*I -Points3DImageSurface(2,1:3);

[I,check]=plane_line_intersect(N,A,Points3DImageSurface(3,1:3),Points3DImageSurface(3,1:3)+N);
Points3DImageSurfaceFake(3,1:3)=2*I -Points3DImageSurface(3,1:3);

[I,check]=plane_line_intersect(N,A,Points3DImageSurface(4,1:3),Points3DImageSurface(4,1:3)+N);
Points3DImageSurfaceFake(4,1:3)=2*I -Points3DImageSurface(4,1:3);

[I,check]=plane_line_intersect(N,A,Points3DImageSurface(5,1:3),Points3DImageSurface(5,1:3)+N);
Points3DImageSurfaceFake(5,1:3)=2*I -Points3DImageSurface(5,1:3);

AFake=Points3DImageSurfaceFake(1,1:3);
BFake=Points3DImageSurfaceFake(2,1:3);
CFake=Points3DImageSurfaceFake(4,1:3);
NormalToPlaneFake=cross(BFake-AFake,CFake-AFake);
NormalToPlaneFake=NormalToPlaneFake/norm(NormalToPlaneFake);
aRealFake=NormalToPlaneFake(1);
bRealFake=NormalToPlaneFake(2);
cRealFake=NormalToPlaneFake(3);
dRealFake=AFake*NormalToPlaneFake';

%%%%%%%
Margin=20;
stepMirror=5;

FirstPointmirror=[choosenX(3)+Margin,choosenY(3)+Margin];%%% the frame of the mirror (from selection of the user) we also can use motion process
SecondPointmirror=[choosenX(4)-Margin,choosenY(4)-Margin];



figure
hold on

%  drawBubble(P1Normal(1),P1Normal(2),P1Normal(3),1,'g','P1Normal','r',0,10);
%  plotLine(P1Normal,Points3DImageSurface(1,1:3),'red');
%  plotLine(Points3DImageSurface(1,1:3),Points3DImageSurfaceFake(1,1:3),'black');
middlePoint=fakeO/2;
drawBubble(middlePoint(1),middlePoint(2),middlePoint(3),1,'g','middlePoint','r',0,10);
drawBubble(fakeO(1),fakeO(2),fakeO(3),1,'g','fakeO','r',0,10);
PM1_InM=[10,40,0];
r=3;
i=1;
%%%%% firstPoint
pmonitor3D1=(PM1_InM*R_m_i)+T_m_i;
ps1=GetMirrorCorresPoint( aReal,bReal,cReal,dReal,pmonitor3D1,fakeO );
piReal1=GetMirrorCorresPoint( 0,0,1,1,[0 0 0],ps1);
piFake1=GetMirrorCorresPoint( aRealFake,bRealFake,cRealFake,dRealFake,ps1,fakeO );
[I,check]=plane_line_intersect(N,A,piFake1,piFake1+N);
piFakeNormalTest1=2*I -piFake1;
%%%%%
%%%get points in surface coordinate system just for checks
ns=GetBisector(oi,ps1,pmonitor3D1); % normal at ps - ns
ns=ns/norm(ns);
%%%%calc the surface mirror coordinate system
V=cross(ps1-pmonitor3D1,pmonitor3D1-oi);
V=V/norm(V);
W=ns;
W=W/norm(W);
U=cross(V,W);
U=U/norm(U);    
Axis_s=[U;V;W;ps1]+[ps1;ps1;ps1;[0,0,0]];
[R_s_i,T_s_i,Yf,Err] = rot3dfit(Axis_i,Axis_s);

%%%%
%%%%%% for checks
pointsMonitor(i,:)=PM1_InM;
pointssurface(i,:)=(ps1-T_s_i)*R_s_i';
pointsImage(i,:)=piFakeNormalTest1;
%


plot3(Points3DMirror(:,1),Points3DMirror(:,2),Points3DMirror(:,3),'b');
for i=1:4
   
    drawBubble(Points3DMirror(i,1),Points3DMirror(i,2),Points3DMirror(i,3),1,'g',int2str(i),'b',0)
end

plot3(Points3DScreen(:,1),Points3DScreen(:,2),Points3DScreen(:,3),'black');
for i=1:4
   
    drawBubble(Points3DScreen(i,1),Points3DScreen(i,2),Points3DScreen(i,3),1,'g',int2str(i),'black',0)
end

plot3(Points3DImageSurface(:,1),Points3DImageSurface(:,2),Points3DImageSurface(:,3),'black');
 
plot3(Points3DImageSurfaceFake(:,1),Points3DImageSurfaceFake(:,2),Points3DImageSurfaceFake(:,3),'black');

for i=1:4
   
    drawBubble(Points3DImageSurfaceFake(i,1),Points3DImageSurfaceFake(i,2),Points3DImageSurfaceFake(i,3),1,'g',int2str(i),'black',0)
end
%%%%%%


count=0;
for i=FirstPointmirror(1):stepMirror:SecondPointmirror(1)
    for j=FirstPointmirror(2):stepMirror:SecondPointmirror(2)
        count=count+1;
        pMiror1=[j,i,1];%%the first mirror point
        pi=(pinv(K)*pMiror1')';
        ps=GetMirrorCorresPoint( aReal,bReal,cReal,dReal,pi,oi );
        pm=GetMirrorCorresPoint( aRealScreen,bRealScreen,cRealScreen,dRealScreen,ps,fakeO );
        pm_i=GetMirrorCorresPoint( 0,0,1,1,pm,oi );   
        pScreen1=round(K*pm_i')';
        %%%%%%%
        pScreen2=[pScreen1(1)-5,pScreen1(2),1];
        pmonitor3D2=(pinv(K)*pScreen2')';
        pmonitor3D2=GetMirrorCorresPoint( aRealScreen,bRealScreen,cRealScreen,dRealScreen,pmonitor3D2,oi );
        ps2=GetMirrorCorresPoint( aReal,bReal,cReal,dReal,pmonitor3D2,fakeO );
        ps_i=GetMirrorCorresPoint( 0,0,1,1,ps2,oi );   
        pMiror2=round(K*ps_i')';
        AllData(count,:)=[pMiror1,pMiror2,pScreen1,pScreen2];
        
%         
%         if count<13
%             plotLine(fakeO,ps,'g');
%             plotLine(ps,pm,'g');
%             plotLine(pmonitor3D2,pm,'b');
%             plotLine(ps,ps2,'b');
%         end
        
    end
end
% AllData=AllData(1:13,:);

%%plot points 
image=movi(40).cdata;
figure;
imagesc(image); hold on;
for i=1:size(AllData,1)
      c=rand(1,3);
      
      
      pMiror1=AllData(i,1:3);
      pMiror2=AllData(i,4:6);
      pScreen1=AllData(i,7:9);
      pScreen2=AllData(i,10:12);
      
      
      plot([pScreen1(1),pMiror1(1)],[pScreen1(2),pMiror1(2)],'-','Color',c)
      plot([pScreen2(1),pMiror2(1)],[pScreen2(2),pMiror2(2)],'-','Color',c)
      
      
end
%%%%%%%%%%


%%%%%%%%


% AllData=AllData(1:400,:);


RealGuess=[aReal,bReal,cReal];
% AllData=AllData(1:13,:)
%  bestGuess=[-0.0199    0.0279    0.0298];
tic
  [bestGuess]=fminsearch(@(args) CheckParameters(args,AllData,K,Points3DScreen,A),RealGuess);

  [sumErrorRealGuess] =CheckParameters(RealGuess,AllData,K,Points3DScreen,A)
  [sumErrorbestGuess] =CheckParameters(bestGuess,AllData,K,Points3DScreen,A)
%   defVaule=sumError;
toc

% delta=0.001;
% f_Tag_x=(CheckParameters(bestGuess+[delta,0,0],AllData,K,Points3DScreen,A)-CheckParameters(bestGuess,AllData,K,Points3DScreen,A))/delta
% f_tag_x_delta=(CheckParameters(bestGuess+[2*delta,0,0],AllData,K,Points3DScreen,A)-CheckParameters(bestGuess+[delta,0,0],AllData,K,Points3DScreen,A))/delta
% f_tagiim_x=(f_Tag_x-f_tag_x_delta)/delta
% 
% 
% f_Tag_y=(CheckParameters(bestGuess+[0,delta,0],AllData,K,Points3DScreen,A)-CheckParameters(bestGuess,AllData,K,Points3DScreen,A))/delta
% f_tag_y_delta=(CheckParameters(bestGuess+[0,2*delta,0],AllData,K,Points3DScreen,A)-CheckParameters(bestGuess+[0,delta,0],AllData,K,Points3DScreen,A))/delta
% f_tagiim_y=(f_Tag_y-f_tag_y_delta)/delta
% 
% f_Tag_z=(CheckParameters(bestGuess+[0,0,delta],AllData,K,Points3DScreen,A)-CheckParameters(bestGuess,AllData,K,Points3DScreen,A))/delta
% f_tag_z_delta=(CheckParameters(bestGuess+[0,0,2*delta],AllData,K,Points3DScreen,A)-CheckParameters(bestGuess+[0,0,delta],AllData,K,Points3DScreen,A))/delta
% f_tagiim_z=(f_Tag_z-f_tag_z_delta)/delta


% GuessToPlot=RealGuess;
% margin=3;
% 
% figure,hold on
% a=GuessToPlot(1)-margin:.5:GuessToPlot(1)+margin;
% b=GuessToPlot(2)-margin:.5:GuessToPlot(2)+margin;
% 
% 
% c=GuessToPlot(3);
% for i=1:size(a,2)
%      z(i)= CheckParameters([a(i),b(i),c],AllData,K,Points3DScreen,A);
% end
% plot3(a,b,z);
% 
% 
% 
% figure,hold on
% b=GuessToPlot(2)-margin:.5:GuessToPlot(2)+margin;
% c=GuessToPlot(3)-margin:.5:GuessToPlot(3)+margin;
% 
% a=GuessToPlot(1);
% for i=1:size(c,2)
%      z(i)= CheckParameters([a,b(i),c(i)],AllData,K,Points3DScreen,A);
% end
% plot3(b,c,z);
% 
% 
% 
% figure,hold on
% a=GuessToPlot(1)-margin:.5:GuessToPlot(1)+margin;
% c=GuessToPlot(3)-margin:.5:GuessToPlot(3)+margin;
% 
% b=GuessToPlot(2);
% for i=1:size(c,2)
%      z(i)= CheckParameters([a(i),b,c(i)],AllData,K,Points3DScreen,A);
% end
% 
% plot3(a,c,z);
% 
% for deltax=-1:0.1:1
%     for deltay=-1:0.1:1
%         for deltaz=-1:0.1:1
%              currGuess=[bestGuess(1)+deltax,bestGuess(2)+deltay,bestGuess(3)+deltaz];
%              [sumError,~] =CheckParameters(currGuess,AllData,K,Points3DScreen,A)
%              if abs(defVaule-sumError)>100
%                  currGuess
%              end
%         end
%     end
% end



figure, hold on
DrawPlane(bestGuess,FirstPointmirror,SecondPointmirror,K,'g',A);
DrawPlane(RealGuess,FirstPointmirror,SecondPointmirror,K,'r',A);
plot3(Points3DMirror(:,1),Points3DMirror(:,2),Points3DMirror(:,3));
for i=1:4
    drawBubble(Points3DMirror(i,1),Points3DMirror(i,2),Points3DMirror(i,3),1,'g',int2str(i),'b',0)
end
plot3(Points3DScreen(:,1),Points3DScreen(:,2),Points3DScreen(:,3));
for i=1:4
    drawBubble(Points3DScreen(i,1),Points3DScreen(i,2),Points3DScreen(i,3),1,'g',int2str(i),'b',0)
end



