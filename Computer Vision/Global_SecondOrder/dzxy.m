function dzxy = dzxy(x,y,z,a,b,c,d,e,f,g,h,m,s)
%DZXY
%    DZXY = DZXY(X,Y,Z,A,B,C,D,E,F,G,H,M,S)

%    This function was generated by the Symbolic Math Toolbox version 5.8.
%    18-Mar-2013 09:13:13

t2 = m.*2.0;
t3 = c.*z.*2.0;
t4 = e.*x.*2.0;
t5 = f.*y.*2.0;
t6 = t2+t3+t4+t5;
dzxy = (d.*2.0)./t6-f.*1.0./t6.^2.*(g.*2.0+a.*x.*2.0+d.*y.*2.0+e.*z.*2.0).*2.0;
