function [ s ] = GetS( a,b,c,d,pMiror1,K )
%get the parameters of surface and the pixel of the mirror and return the
%depth in the point pMiror1

Pointi=pinv(K)*pMiror1';% of the mirror 

n=[a,b,c];
V0=[1,1,-(a+b-d)/c];
P0=[0,0,0];
P1=Pointi';

[I,check]=plane_line_intersect(n,V0,P0,P1);

s=I(3);




end

