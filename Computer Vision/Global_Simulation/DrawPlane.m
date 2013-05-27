function DrawPlane( args,FirstPointmirror,SecondPointmirror,K ,color,pointOnMirror)
% args(4)=args(3);
% delta=1-(args(1)^2+args(2)^2);
% if delta<0
%     args(3)=0;
% else
%     args(3)=sqrt(delta);
% 
% end
args(4)=pointOnMirror*args';

pMiror1=[FirstPointmirror(2),FirstPointmirror(1),1];
pMiror3=[SecondPointmirror(2),SecondPointmirror(1),1];
pMiror2=[SecondPointmirror(2),FirstPointmirror(1),1];
pMiror4=[FirstPointmirror(2),SecondPointmirror(1),1];

step=50;
a=args(1);
b=args(2);
c=args(3);

d=args(4);
s=GetS( a,b,c,d,pMiror1,K);
p1=pinv(K)*pMiror1'*s;

s=GetS( a,b,c,d,pMiror2,K);
p2=pinv(K)*pMiror2'*s;

s=GetS( a,b,c,d,pMiror3,K);
p3=pinv(K)*pMiror3'*s;

s=GetS( a,b,c,d,pMiror4,K);
p4=pinv(K)*pMiror4'*s;


% p2=[p1(1), p1(2)+step,getZ(a,b,c,d,p1(1),p1(2)+step)];
% p3=[p1(1)+step, p1(2)+step,getZ(a,b,c,d,p1(1)+step,p1(2)+step)];
% p4=[p1(1)+step, p1(2),getZ(a,b,c,d,p1(1)+step,p1(2))];

X=[p1(1),p2(1),p3(1),p4(1)];
Y=[p1(2),p2(2),p3(2),p4(2)];
Z=[p1(3),p2(3),p3(3),p4(3)];
patch(X, Y, Z, color)


end


function z= getZ(a,b,c,d,x,y)
if c==0
   c=0.000000001;
end
    z=(d-(x*a+y*b))/c;


end
