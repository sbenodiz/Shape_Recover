args=[1,10,20,30,220,50,60,70,80,90];
%      a b   c  d  e  f  g   h  m s

a=args(1);b=args(2);c=args(3);d=args(4);e=args(5);f=args(6);g=args(7);h=args(8);m=args(9);s=args(10); %M=i  , j = s

syms x y z real


Q=[a,d,e,g;
   d,b,f,h;
   e,f,c,m;
   g,h,m,s];
X=[x,y,z,1]';

func(x,y,z)=X'*Q*X;

[parameters,Eqations]=coeffs(func)
parameters= sym2poly(parameters(x,y,z));

EqationsCells=arrayfun(@char,Eqations(x,y,z),'Un',0);


SerachRes=Myeq(C,{'matrix([[x^2, 1, 1]])'});
index= GetSearchIndex( SerachRes );
a=parameters(index);

SerachRes=Myeq(C,{'matrix([[x, x, 1]])'});
index= GetSearchIndex( SerachRes );
d=parameters(index)/2;

SerachRes=Myeq(C,{'matrix([[x, 1, x]])'});
index= GetSearchIndex( SerachRes );
e=parameters(index)/2;


SerachRes=Myeq(C,{'matrix([[x, 1, 1]])'});
index= GetSearchIndex( SerachRes );
g=parameters(index)/2;

SerachRes=Myeq(C,{'matrix([[1, x^2, 1]])'});
index= GetSearchIndex( SerachRes );
b=parameters(index);

SerachRes=Myeq(C,{'matrix([[1, x, x]])'});
index= GetSearchIndex( SerachRes );
f=parameters(index)/2;

SerachRes=Myeq(C,{'matrix([[1, x, 1]])'});
index= GetSearchIndex( SerachRes );
h=parameters(index)/2;

SerachRes=Myeq(C,{'matrix([[1, 1, x^2]])'});
index= GetSearchIndex( SerachRes );
c=parameters(index);

SerachRes=Myeq(C,{'matrix([[1, 1, x]])'});
index= GetSearchIndex( SerachRes );
m=parameters(index)/2;


SerachRes=Myeq(C,{'matrix([[1, 1, 1]])'});
index= GetSearchIndex( SerachRes );
s=parameters(index);

args2=[a,b,c,d,e,f,g,h,m,s]
args