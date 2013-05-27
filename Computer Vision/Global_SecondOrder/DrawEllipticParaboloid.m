function DrawEllipticParaboloid( args,FirstPointmirror,SecondPointmirror,K ,equation)
a=args(1);b=args(2);c=args(3);d=args(4);e=args(5);f=args(6);g=args(7);h=args(8);m=args(9);j=args(10); %m_args=i 

pMiror1=[FirstPointmirror(2),FirstPointmirror(1),1];
pMiror3=[SecondPointmirror(2),SecondPointmirror(1),1];



P_3D1=GetIntersectionPointQuadricSurface( args,pMiror1,K,equation )
P_3D3=GetIntersectionPointQuadricSurface( args,pMiror3,K,equation )



gv_x=linspace(P_3D1(1)-1,P_3D3(1)+1,50);
gv_y=linspace(P_3D1(2)-1,P_3D3(2)+1,50);
gv_z=linspace(P_3D1(3)-1,P_3D3(3)+1,50);

[xx yy zz]=meshgrid(gv_x, gv_y, gv_z);

F = a*xx.^2 + b*yy.^2 + c*zz.^2 + 2*d*xx.*yy + 2*e*xx.*zz + 2*f*yy.*zz + 2*g*xx + 2*h*yy + 2*m*zz +j;

% figure, hold on
isosurface(xx, yy, zz, F, 2)
xlabel('X')
ylabel('Y')
zlabel('Z')




end

