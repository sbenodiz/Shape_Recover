function [ aa,bb,cc ] = Getabc( args,T_s_i,R_s_i)
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
zz=0;
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
syms x y z real
X=[x,y,z,1]';

funcToConvert(x,y,z)=X'*Q*X; %%calc Quadric Surfaces in General Form


xNew=([x,y,z]-T_s_i)*R_s_i(:,1); 
yNew=([x,y,z]-T_s_i)*R_s_i(:,2);
zNew=([x,y,z]-T_s_i)*R_s_i(:,3);

funcToConvert(x,y,z)=funcToConvert(xNew,yNew,zNew); %%% convert equation parameters to the surface coordinate system


%%% get new parameters for the new equation
[parameters,Eqations]=coeffs(funcToConvert);  
parameters= sym2poly(parameters(x,y,z));

EqationsCells=arrayfun(@char,Eqations(x,y,z),'Un',0);

%%%% just to find those parameter that are aero
a=getParametersValue(parameters,EqationsCells,{'matrix([[x^2, 1, 1]])'},1);
d=getParametersValue(parameters,EqationsCells,{'matrix([[x, x, 1]])'},0.5);
e=getParametersValue(parameters,EqationsCells,{'matrix([[x, 1, x]])'},0.5);
g=getParametersValue(parameters,EqationsCells,{'matrix([[x, 1, 1]])'},0.5);
b=getParametersValue(parameters,EqationsCells,{'matrix([[1, x^2, 1]])'},1);
f=getParametersValue(parameters,EqationsCells,{'matrix([[1, x, x]])'},0.5);
h=getParametersValue(parameters,EqationsCells,{'matrix([[1, x, 1]])'},0.5);
c=getParametersValue(parameters,EqationsCells,{'matrix([[1, 1, x^2]])'},1);
m=getParametersValue(parameters,EqationsCells,{'matrix([[1, 1, x]])'},0.5);
j=getParametersValue(parameters,EqationsCells,{'matrix([[1, 1, 1]])'},0.5);
%%% end convert parameters


aa= zfunc(1,yy,0,a,b,c,d,e,f,g,h,m,j)*2;% w= 1/2*a*u^2+c*u*v +1/2 *b*v^2   %% we multiple by 2 because 1/2
bb=zfunc(xx,1,0,a,b,c,d,e,f,g,h,m,j)*2;% w= 1/2*a*u^2+c*u*v +1/2 *b*v^2   %% we multiple by 2 because 1/2
cc=dzxy(0,0,0,a,b,c,d,e,f,g,h,m,j);

% tempResX= (sym2poly(subs(zfunc,{'y','a','b','c','d','e','f','g','h','m','s'},{yy,a,b,c,d,e,f,g,h,m,j}))*2);% w= 1/2*a*u^2+c*u*v +1/2 *b*v^2   %% we multiple by 2 because 1/2
% aa=tempResX(1);
% tempResY=(sym2poly(subs(zfunc,{'x','a','b','c','d','e','f','g','h','m','s'},{xx,a,b,c,d,e,f,g,h,m,j}))*2);% w= 1/2*a*u^2+c*u*v +1/2 *b*v^2   %% we multiple by 2 because 1/2
% bb=tempResY(1);
% cc=subs(dzxy(0,0,0),{'a','b','c','d','e','f','g','h','m','s'},{a,b,c,d,e,f,g,h,m,j});

end


function val=getParametersValue(parameters,EqationsCells,currParam,multipleConst)
    SerachRes=Myeq(EqationsCells,currParam);
    index= GetSearchIndex( SerachRes );
    if 0==index
        val=0;
    else
        val=parameters(index)*multipleConst;
    end

end

