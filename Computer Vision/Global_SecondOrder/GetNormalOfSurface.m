
% a=args(1);b=args(2);c=args(3);d=args(4);e=args(5);f=args(6);g=args(7);h=args(8);m=args(9);s=args(10); %M=i  , j = s



syms x y z x0 y0 z0 a b c d e f g h m s real



func(x,y,z,x0,y0,z0,a,b,c,d,e,f,g,h,m,s)=a*x0*x+b*y0*y+c*z0*z+d*(z0*y+y0*z)+e*(x0*z+z0*x)+f*(y0*x+x0*y)+g*(x+x0)+h*(y+y0)+m*(z+z0)+s;


matlabFunction(func,'file','GetTangentPlane')