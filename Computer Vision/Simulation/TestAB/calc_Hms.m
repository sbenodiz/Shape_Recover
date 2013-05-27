function [ sumError ] = calc_Hms( args,ThetaIn,s,p0Norm,a,b,c,HmsReal )



R=ang2orth(args);

Xm_s=R(1,1:3);
Ym_s=R(2,1:3);

A=calcA(ThetaIn,s,p0Norm,a,b,c);
B=calcB(ThetaIn,p0Norm,Xm_s,Ym_s);
Hms=A*B;

res=Hms./HmsReal;
sumError=(res(1,1)-res(1,2)).^2;
sumError=sumError+(res(1,2)-res(2,1)).^2;
sumError=sumError+(res(2,1)-res(2,2)).^2;

% 
% res=(Hms-HmsReal).^2;
% sumError=sum(res(:));



end

