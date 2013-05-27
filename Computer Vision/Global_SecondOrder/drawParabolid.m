function drawParabolid(args)
args=[args(1),args(2),args(3),0,0,0,args(5),args(5),args(6),args(7)];


a=args(1);b=args(2);c=args(3);d=args(4);e=args(5);f=args(6);g=args(7);h=args(8);m=args(9);j=args(10); %m_args=i 


gv = linspace(-30,30,50); % adjust for appropriate domain
[xx yy zz]=meshgrid(gv, gv, gv);
F = a*xx.^2 + b*yy.^2 + c*zz.^2 + 2*d*xx.*yy + 2*e*xx.*zz + 2*f*yy.*zz + 2*g*xx + 2*h*yy + 2*m*zz +j;

isosurface(xx, yy, zz, F, 0)
xlabel('X')
ylabel('Y')
zlabel('Z')





end
