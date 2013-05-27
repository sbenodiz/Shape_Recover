function [grade] = CheckPoint(args,pMiror1 ,pMiror2,pScreen1,pScreen2,s,K,Points3DScreen)
%get point and the parameters a,b,c and the depth s and return grade for
%this guess (the guess is s that come from the guess of the plane eqation)


%%% calc the movment vectors and their approximation
[angle_si_Estimate,angle_si,Vector_Si_estimate,Vector_Si,errorVal] = GetValues(args,s,pMiror1,pMiror2,pScreen1,pScreen2,K,Points3DScreen);

% grade=errorVal;
 grade=sum((Vector_Si-Vector_Si_estimate).^2)+sum((angle_si_Estimate-angle_si).^2);

end

