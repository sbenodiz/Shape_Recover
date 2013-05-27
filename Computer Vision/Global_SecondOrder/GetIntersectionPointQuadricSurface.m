function [ point ] = GetIntersectionPointQuadricSurface( args,pMiror1,K,equation )
%get the parameters of surface and the pixel of the mirror and return the
%depth in the point pMiror1
%X=x1+Vx*t  Y=y1+Vy*t Z=z1+Vz*t 
%Z=a*X^2+b*Y^2+c
Pointi=pinv(K)*pMiror1';% of the mirror 

P0=[0,0,0];
P1=Pointi';



a=args(1);b=args(2);c=args(3);d=args(4);e=args(5);f=args(6);g=args(7);h=args(8);m=args(9);j=args(10); %M=i


x1=P0(1);y1=P0(2);z1=P0(3);x2=P1(1);y2=P1(2);z2=P1(3);



Vx=P1(1)-P0(1);% calc the vector between the points
Vy=P1(2)-P0(2);
Vz=P1(3)-P0(3);


if a==0 && b==0 
     s=GetS( g,h,m,j,pMiror1,K); %calc s from the plane equation;
     point=[0,0,s];
     return 
end
% equation=solve('a*(x1+t*Vx)^2+b*(y1+t*Vy)^2+c*(z1+t*Vz)^2+2*d*(x1+t*Vx)*(y1+t*Vy)+2*e*(x1+t*Vx)*(z1+t*Vz)+2*f*(z1+t*Vz)*(y1+t*Vy)+2*g*(x1+t*Vx)+2*h*(y1+t*Vy)+2*m*(z1+t*Vz)+j=0','t');
%load('equation');
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
    
     
     if  pdist([[0,0,0];resP1],'euclidean')>pdist([[0,0,0];resP2],'euclidean')
         point=resP2;
     else
         point=resP1;
         
     end
     
 else
     point=[0,0,0];
     
 end




end

