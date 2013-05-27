function B=calcB(o,p0Norm,Xms,Yms)
scalar=1/p0Norm;
B=[-((cos(o))^2) 0 cos(o)*sin(o);0 -1 0]*[Xms',Yms'];
B=scalar.*B;
end