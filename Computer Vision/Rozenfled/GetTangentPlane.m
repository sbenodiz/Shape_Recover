function func = GetTangentPlane(a,b,c,d,e,f,g,h,m,s,x,x0,y,y0,z,z0)
%GETTANGENTPLANE
%    FUNC = GETTANGENTPLANE(A,B,C,D,E,F,G,H,M,S,X,X0,Y,Y0,Z,Z0)

%    This function was generated by the Symbolic Math Toolbox version 5.8.
%    15-Apr-2013 19:17:18

func = s+g.*(x+x0)+h.*(y+y0)+m.*(z+z0)+f.*(x.*y0+x0.*y)+e.*(x.*z0+x0.*z)+d.*(y.*z0+y0.*z)+a.*x.*x0+b.*y.*y0+c.*z.*z0;