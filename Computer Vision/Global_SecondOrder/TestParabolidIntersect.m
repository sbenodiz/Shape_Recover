close all;

addpath('C:\Users\SAAR\MATLAB\Computer Vision\Rozenfled'); %for plot line

% R=10;
% a=1;b=1;c=1;d=0;e=0;f=0;g=0;h=0;j=0;m=0.5*R*(-2*R); %M=i
% args=[1.8994,0.7559,0.0194,0,0,0,-26.4118,17.8413, -3.5516, 765.1961];
% args=[ 1.0000    1.0000    1.0000         0         0         0  -2.5704   -6.1079  -30.5836  953.4636];
args=[ 1.5704    2.1079   15.5836];
    
x1=args(1);
y1=args(2);
z1=args(3);
r=5.08;
args=[1,1,1,0,0,0,-x1,-y1,-z1,x1^2+y1^2+z1^2-r^2];

a=args(1);b=args(2);c=args(3);d=args(4);e=args(5);f=args(6);g=args(7);h=args(8);m=args(9);j=args(10); %m_args=i 


P0=[0,0,0];
P1=[ 0.1197   -0.0765    1.0000];

% 
% [x,y]=meshgrid(-100:0.025:100,-100:0.025:100);
% z=a*x.^2+b*y.^2+c;
% z(z>2*2.5^2)=NaN; % Any points above a certain Z value get clipped.
% figure, hold on
% f=surf(x,y,z); 
% set(f,'edgecolor','none') % Avoids the entire surface appearing black


gv = linspace(-60,60,50); % adjust for appropriate domain
[xx yy zz]=meshgrid(gv, gv, gv);%TODO, Take the 2 3d points and get all xx yy zz that between them

F = a*xx.^2 + b*yy.^2 + c*zz.^2 + 2*d*xx.*yy + 2*e*xx.*zz + 2*f*yy.*zz + 2*g*xx + 2*h*yy + 2*m*zz +j;

figure, hold on
isosurface(xx, yy, zz, F, 0)
xlabel('X')
ylabel('Y')
zlabel('Z')





plot3(Points3DScreen(:,1),Points3DScreen(:,2),Points3DScreen(:,3));
for i=1:4
    drawBubble(Points3DScreen(i,1),Points3DScreen(i,2),Points3DScreen(i,3),1,'g',int2str(i),'r',0)
end

x1=P0(1);y1=P0(2);z1=P0(3);x2=P1(1);y2=P1(2);z2=P1(3);

Vx=P1(1)-P0(1);
Vy=P1(2)-P0(2);
Vz=P1(3)-P0(3);

  plotLine(P0,P1+[Vx*100,Vy*100,Vz*100],'b');
% equation=solve('a*(x1+t*Vx)^2+b*(y1+t*Vy)^2+c*(z1+t*Vz)^2+2*d*(x1+t*Vx)*(y1+t*Vy)+2*e*(x1+t*Vx)*(z1+t*Vz)+2*f*(z1+t*Vz)*(y1+t*Vy)+2*g*(x1+t*Vx)+2*h*(y1+t*Vy)+2*m*(z1+t*Vz)+j=0','t');

% save('equation','equation');
load('equation');
T=subs(equation);
t1=T(1);
t2=T(2);

 if isreal(T)
  
     resP1(1)=x1+Vx*t1;
     resP1(2)=y1+Vy*t1;
     resP1(3)=z1+Vz*t1;

     resP2(1)=x1+Vx*t2;
     resP2(2)=y1+Vy*t2;
     resP2(3)=z1+Vz*t2;
     plot3(resP1(1),resP1(2),resP1(3),'ro');
     plot3(resP2(1),resP2(2),resP2(3),'ro');   
     
     
 end

