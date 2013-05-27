function [grade] = CheckPoint(pMiror1 ,pMiror2,pScreen1,pScreen2,a,b,c,s,K,Points3DScreen)
%get point and the parameters a,b,c and the depth s and return grade for
%this guess (the guess is s that come from the guess of the plane eqation)


%%% calc the movment vectors and their approximation
[angle_si_Estimate,angle_si,Vector_Si_estimate,Vector_Si] = GetValues( a,b,c,s,pMiror1,pMiror2,pScreen1,pScreen2,K,Points3DScreen);


 grade=sum((Vector_Si-Vector_Si_estimate).^2);%+sum((angle_si_Estimate-angle_si).^2);
% grade=sum((angle_si_Estimate-angle_si).^2);
end

