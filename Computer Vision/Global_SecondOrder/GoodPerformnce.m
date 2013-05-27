

clear;


%
 tic
r=4;
xx=0;
yy=0;
zz=0;
args=[1,2,3,0,0,0,0,0,-r,0];
a_args=args(1);b_args=args(2);c_args=args(3);d_args=args(4);e_args=args(5);f_args=args(6);g_args=args(7);h_args=args(8);m_args=args(9);s_args=args(10); %M=i  , j = s




r=4;
if 0==a_args && 0==b_args && 0==c_args
   aa=0;bb=0;cc=0;
   return;
end

T_m_i=[0,0,1];
R_m_i=eye(3,3);
R_m_i=[0,0,1;1,0,0;0,1,0];
%%%Start convert parameters
% R_m_i_t=R_m_i';
Q=[a_args,d_args,e_args,g_args;
   d_args,b_args,f_args,h_args;
   e_args,f_args,c_args,m_args;
   g_args,h_args,m_args,s_args];


RT=[R_m_i,T_m_i';0,0,0,1];
newQ=pinv(RT)'*Q*pinv(RT);





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


 args=[a,b,c,d,e,f,g,h,m,s]
tic
aa= zfunc(1,yy,0,a,b,c,d,e,f,g,h,m,s)*2% w= 1/2*a*u^2+c*u*v +1/2 *b*v^2   %% we multiple by 2 because 1/2
bb=zfunc(xx,1,0,a,b,c,d,e,f,g,h,m,s)*2% w= 1/2*a*u^2+c*u*v +1/2 *b*v^2   %% we multiple by 2 because 1/2
cc=dzxy(0,0,0,a,b,c,d,e,f,g,h,m,s);
toc

