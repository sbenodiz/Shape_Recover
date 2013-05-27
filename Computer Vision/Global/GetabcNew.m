function [ aa,bb,cc ] = GetabcNew( args,T_i_s,R_i_s)
%%% this function retrn a,b,c parameters for the eqations - args in  the
%%% surface coordinate system , we use transltion -T_s_i and rotation
%%% -R_s_i to transform the equation to surface coordinate system. as well
%%% we use the second oreder approximation zfunc that we calc in the file
%%% Derative.m to get better perfemonce. for the approximation we use
%%% Taylor series.
%%% we calc a,b,c in the point 0,0,0 (xx,yy,zz). we following the equation
%%% w=1/2*a*u^2 +c*u*v+1/2*b*v^2

 
xx=0;
yy=0;
a_args=args(1);b_args=args(2);c_args=args(3);d_args=args(4);e_args=args(5);f_args=args(6);g_args=args(7);h_args=args(8);m_args=args(9);j_args=args(10); %m_args=i 


if 0==a_args && 0==b_args && 0==c_args
   aa=0;bb=0;cc=0;
   return;
end

% syms x y z real
%%% start convert parameters
Q=[a_args,d_args,e_args,g_args;
   d_args,b_args,f_args,h_args;
   e_args,f_args,c_args,m_args;
   g_args,h_args,m_args,j_args];

RT=[R_i_s,T_i_s';0,0,0,1];
newQ=(RT')*Q*((RT));

% ps*newQ*ps'

a=newQ(1,1);
b=newQ(2,2);
c=newQ(3,3);
d=newQ(1,2);
e=newQ(1,3);
f=newQ(2,3);
g=newQ(1,4);
h=newQ(2,4);
m=newQ(3,4);
s=newQ(4,4);
% myargs=[a,b,c,d,e,f,g,h,m,s];
aa= zfunc(1,yy,0,a,b,c,d,e,f,g,h,m,s)*2;% w= 1/2*a*u^2+c*u*v +1/2 *b*v^2   %% we multiple by 2 because 1/2
bb=zfunc(xx,1,0,a,b,c,d,e,f,g,h,m,s)*2;% w= 1/2*a*u^2+c*u*v +1/2 *b*v^2   %% we multiple by 2 because 1/2
cc=dzxy(0,0,0,a,b,c,d,e,f,g,h,m,s);
end