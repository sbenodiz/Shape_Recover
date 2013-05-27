close all

load('3dPoints');


figure
hold on

plot3(Points3DMirror(:,1),Points3DMirror(:,2),Points3DMirror(:,3));
for i=1:4
   
    drawBubble(Points3DMirror(i,1),Points3DMirror(i,2),Points3DMirror(i,3),1,'g',int2str(i),'b',0)
end

plot3(Points3DScreen(:,1),Points3DScreen(:,2),Points3DScreen(:,3));
for i=1:4
   
    drawBubble(Points3DScreen(i,1),Points3DScreen(i,2),Points3DScreen(i,3),1,'g',int2str(i),'black',0)
end
 %%%% plot surface cooedinate system in the image coordinate system
 plotLine(U+ps,ps,'g')
 plotLine(V+ps,ps,'r')
 plotLine(W+ps,ps,'b')
%  ps
 %%%%

 %%%% plot monitor coordinate system in the image coordinate system
 plotLine(Xm_i+om_i,om_i,'g')
 plotLine(Ym_i+om_i,om_i,'r')
 plotLine(Zm_i+om_i,om_i,'b')
 %%%
 
 %%%% plot image coordinate system in the image coordinate system
 plotLine(Xi+oi,oi,'g')
 plotLine(Yi+oi,oi,'r')
 plotLine(Zi+oi,oi,'b')
 %%%
 
 
 plotLine(oi,ps,'y')
 plotLine(pm,ps,'y')
 plotLine(pmonitor3D1,pmonitor3D2,'black')
 plotLine(Pointi,Pointi_2,'black')
  plotLine(ps,ps2,'black')

 drawBubble(ps(1),ps(2),ps(3),1,'g','ps','r',0,10)
 drawBubble(ps2(1),ps2(2),ps2(3),1,'g','ps2','r',0,10)

 drawBubble(oi(1),oi(2),oi(3),1,'g','oi','r',0,10)
 drawBubble(pmonitor3D1(1),pmonitor3D1(2),pmonitor3D1(3),1,'g','pm1','r',0,10)
 drawBubble(pmonitor3D2(1),pmonitor3D2(2),pmonitor3D2(3),1,'g','pm2','r',0,10)
%  drawBubble(ps_image1(1),ps_image1(2),ps_image1(3),1,'g','Psi1','r',0,10)
%  drawBubble(ps_image2(1),ps_image2(2),ps_image2(3),1,'g','Psi2','r',0,10)
%  
 
 

 
 