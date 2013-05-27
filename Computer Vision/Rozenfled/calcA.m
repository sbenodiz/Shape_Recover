function A=calcA(o,s,p0Norm,a,b,c)

Ju=calcJu(o,s,p0Norm);
Jv=calcJv(s,p0Norm);

A=(1/calcDelta(Ju,Jv,o,a,b,c));
A=A*[Jv-2*b*cos(o) 2*c*cos(o); 2*c*cos(o) Ju-2*a*cos(a)];
end




function  Ju=calcJu(o,s,p0Norm)
    Ju=((cos(o))^2 )* (s+p0Norm)/(s* p0Norm);
end

function  Jv=calcJv(s,p0Norm)
    Jv= (s+norm(p0Norm))/(s* p0Norm);
end


function  delta=calcDelta(Ju,Jv,o,a,b,c)
    delta= ((Ju-2*a*cos(o))*(Jv-2*b*cos(o)))-((2*c*cos(o))^2);
end