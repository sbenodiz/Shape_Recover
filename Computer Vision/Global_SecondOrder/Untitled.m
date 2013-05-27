  figure, hold on
%  
%  
 moviAll = ReadAvi('screen_12.4.13.avi');
 load('K')
 imagesc(moviAll(5).cdata)
 points=[364.1935  259.0125; 360.2097  214.5439; 404.9194  227.3339
    393.2258  257.4451];
%plot two points that are correspance
 plot(points(:,1),points(:,2),'ro')

%  ginput(2)
% % % 
% % % center=[7.9943   -1.2308   32.1662 ];
% % % centerPixel=(K*center');;
% % % 
% % % centerPixel=centerPixel/centerPixel(3);
% % % plot(centerPixel(1),centerPixel(2),'gx')
% % 
% 
% p13d=Get3DPoint(Points3DScreen,[p1,1],K)
% p23d=Get3DPoint(Points3DScreen,[p2,1],K)
% 
%  return;

S=[16:0.01:34]; % multiple guess for depth-s
oi=[0,0,0];%origin
centerMat=[];
% monitor=AllData(:,1:3);
% surface=AllData(:,7:9);
monitor=[364.1935  259.0125,1 ;360.2097  214.5439,1]; %monitor points
surface=[393.2258  257.4451,1; 404.9194  227.3339,1]; %surface points
plot(monitor(:,1),monitor(:,2),'ro')
plot(surface(:,1),surface(:,2),'ro')
% for i=1:size(surface,1)
%    
%   pm= Get3DPoint(Points3DScreen,monitor(i,:),K);
%   ps=(pinv(K)*surface(i,:)')';
%   for j=1:size(S,2)
%     res=ps*S(j);
%     ns=GetBisector(oi,res,pm); % normal at ps-Bisector
%     ns=ns/norm(ns);
%     centerMat(i,j,:)=res-(ns*5.08);
%   end
% 
% 
% end


% si=size(centerMat,2)*size(centerMat,1);
% plot3(reshape(centerMat(:,:,1),si,1),reshape(centerMat(:,:,2),si,1),reshape(centerMat(:,:,3),si,1),'.')
% axis equal
%% 
%find the center of the ball by distance between two points
st1=[390.7419,271.68471,1];
st2=[601.7097,271.6847,1];
realCenter=[489.9355,258.8439,1];
st1k=pinv(K)*st1';
st2k=pinv(K)*st2';
realCenterk=pinv(K)*realCenter';
z=5.08*2/(norm(st1k-st2k));
center3D=realCenterk*z;


%%
%find the 3D points on the screen from the center of the ball
currIndex=1; %index of the current points to calculate

%%%find ps, find the real s 
dist=[];
 for j=1:size(S,2)
    
      ps=(pinv(K)*surface(currIndex,:)')';
      res=ps*S(j);
      dist(j)=abs(norm(res-center3D')-5.08);
      
 end
sIndex=find(dist==min(dist));
Ps=ps*S(sIndex);
ns=Ps-center3D';
ns=ns/norm(ns);
V1=[(oi(1)-Ps(1)) (oi(2)-Ps(2)) (oi(3)-Ps(3))];
V1=V1/norm(V1);
V2=V1-ns;
V2=V2/norm(V2);
PmV=V2;  %%calculate the vector to pm from the bisector ns
pm=(pinv(K)*monitor(currIndex,:)')';

PM=lineIntersect3D([oi;Ps],[oi+pm*30;Ps+PmV*(-30)]);
figure,hold on

plot3(oi(1),oi(2),oi(3),'X','MarkerSize',22);
plot3(Ps(1),Ps(2),Ps(3),'X','MarkerSize',22);
plot3(center3D(1),center3D(2),center3D(3),'ro','MarkerSize',22);

plot3([center3D(1);Ps(1)],[center3D(2);Ps(2)],[center3D(3);Ps(3)]);
plot3([oi(1);Ps(1)],[oi(2);Ps(2)],[oi(3);Ps(3)]);
plot3([oi(1);pm(1)*50],[oi(2);pm(2)*50],[oi(3);pm(3)*50]);
plot3([Ps(1);Ps(1)+ns(1)],[Ps(2);Ps(2)+ns(2)],[Ps(3);Ps(3)+ns(3)]);

plot3([Ps(1);Ps(1)+PmV(1)*(-15)],[Ps(2);Ps(2)+PmV(2)*(-15)],[Ps(3);Ps(3)+PmV(3)*(-15)]);

plot3(PM(1),PM(2),PM(3),'ro','MarkerSize',22);

PM_es=Get3DPoint(Points3DScreen,monitor(currIndex,:),K); %pm estimate from the 3d points of the screen
norm(PM-PM_es)
