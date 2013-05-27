

% clear;


 tic
r=5.08;
xx=0;
yy=0;
zz=0;
args=[1,1,1,0,0,0,0,0,-r,0];
a_args=args(1);b_args=args(2);c_args=args(3);d_args=args(4);e_args=args(5);f_args=args(6);g_args=args(7);h_args=args(8);m_args=args(9);s_args=args(10); %M=i  , j = s


syms x y z real %0.17


r=4;
if 0==a_args && 0==b_args && 0==c_args
   aa=0;bb=0;cc=0;
   return;
end

T_m_i=[0,0,0];
R_m_i=eye(3,3);
% R_m_i=[0,0,1;1,0,0;0,1,0];

%%%Start convert parameters
Q=[a_args,d_args,e_args,g_args;
   d_args,b_args,f_args,h_args;
   e_args,f_args,c_args,m_args;
   g_args,h_args,m_args,s_args];

X=[x,y,z,1]';

% tic  %%%0.1
funcToConvert(x,y,z)=X'*Q*X;
xNew=([x,y,z]-T_m_i)*R_m_i(:,1);
yNew=([x,y,z]-T_m_i)*R_m_i(:,2);
zNew=([x,y,z]-T_m_i)*R_m_i(:,3);
funcToConvert(x,y,z)=funcToConvert(xNew,yNew,zNew);
% toc%%%0.1
% tic

[parameters,Eqations]=coeffs(funcToConvert);
parameters= sym2poly(parameters(x,y,z));

EqationsCells=arrayfun(@char,Eqations(x,y,z),'Un',0);


SerachRes=Myeq(EqationsCells,{'matrix([[x^2, 1, 1]])'});
index= GetSearchIndex( SerachRes );
if 0==index
    a=0;
else
    a=parameters(index);
end


SerachRes=Myeq(EqationsCells,{'matrix([[x, x, 1]])'});
index= GetSearchIndex( SerachRes );
if 0==index
    d=0;
else
    d=parameters(index)/2;
end

SerachRes=Myeq(EqationsCells,{'matrix([[x, 1, x]])'});
index= GetSearchIndex( SerachRes );
if 0==index
    e=0;
else
    e=parameters(index)/2;
end



SerachRes=Myeq(EqationsCells,{'matrix([[x, 1, 1]])'});
index= GetSearchIndex( SerachRes );
if 0==index
    g=0;
else
    g=parameters(index)/2;
end


SerachRes=Myeq(EqationsCells,{'matrix([[1, x^2, 1]])'});
index= GetSearchIndex( SerachRes );
if 0==index
    b=0;
else
    b=parameters(index);
end


SerachRes=Myeq(EqationsCells,{'matrix([[1, x, x]])'});
index= GetSearchIndex( SerachRes );
if 0==index
    f=0;
else
    f=parameters(index)/2;
end


SerachRes=Myeq(EqationsCells,{'matrix([[1, x, 1]])'});
index= GetSearchIndex( SerachRes );
if 0==index
    h=0;
else
    h=parameters(index)/2;
end


SerachRes=Myeq(EqationsCells,{'matrix([[1, 1, x^2]])'});
index= GetSearchIndex( SerachRes );
if 0==index
    c=0;
else
    c=parameters(index);
end


SerachRes=Myeq(EqationsCells,{'matrix([[1, 1, x]])'});
index= GetSearchIndex( SerachRes );
if 0==index
    m=0;
else
    m=parameters(index)/2;
end



SerachRes=Myeq(EqationsCells,{'matrix([[1, 1, 1]])'});
index= GetSearchIndex( SerachRes );
if 0==index
    s=0;
else
    s=parameters(index);
end



%%%End convert parameters



args=[a,b,c,d,e,f,g,h,m,s]
tic
aa= zfunc(1,yy,0,a,b,c,d,e,f,g,h,m,s)*2% w= 1/2*a*u^2+c*u*v +1/2 *b*v^2   %% we multiple by 2 because 1/2
bb=zfunc(xx,1,0,a,b,c,d,e,f,g,h,m,s)*2% w= 1/2*a*u^2+c*u*v +1/2 *b*v^2   %% we multiple by 2 because 1/2
cc=dzxy(0,0,0,a,b,c,d,e,f,g,h,m,s);
toc


% 
%  tic
% tempResX= (sym2poly(subs(zfunc,{'y','a','b','c','d','e','f','g','h','m','s'},{yy,a,b,c,d,e,f,g,h,m,s}))*2);% w= 1/2*a*u^2+c*u*v +1/2 *b*v^2   %% we multiple by 2 because 1/2
% aa=tempResX(1);
% tempResY=(sym2poly(subs(zfunc,{'x','a','b','c','d','e','f','g','h','m','s'},{xx,a,b,c,d,e,f,g,h,m,s}))*2);% w= 1/2*a*u^2+c*u*v +1/2 *b*v^2   %% we multiple by 2 because 1/2
% bb=tempResY(1);
% cc=subs(dzxy(0,0,0),{'a','b','c','d','e','f','g','h','m','s'},{a,b,c,d,e,f,g,h,m,s});
%  toc
