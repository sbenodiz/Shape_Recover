% clear
load('AllPointsForTests');
A=[ 22.732 0;0 11.816];
B=[ -0.0072   -0.0223;0.0592   -0.0030];
Hms1=[   -0.1637   -0.5069;     0.6995   -0.0354];   %A*B;
% Hms2=[   38.1343   37.7904;     -4.8891   -5.6240];   % test XY_MS +Oms 
% Hms3=[   0.7289    0.7321;     -0.0935   -0.1090];   %test XY_MS+Oms + norm
% Hms4=[    -0.5464   -0.0140;     0.0503    0.7619];   %test + X<->Y
 Hms5=[    0.0485   -0.8221;      -0.6996    0.0352];   %change calcB

% Hmi=[   -0.0026   -0.0176;   0.0183   -0.0022];
HmsRealFromHmi=[ 0.0530   -0.8716;-0.7360    0.0372];


MyHms=Hms5;
SumError=0;
for i=2:size(pointsMonitor)

  Vector_Pm=pointsMonitor(i,:)-pointsMonitor(1,:);  
  Vector_Ps=pointssurface(i,:)-pointssurface(1,:);
  Vs_Estimate=(Vector_Pm(1:2)*MyHms);
  
  SumError=SumError+sum( (Vector_Ps(1:2)-Vs_Estimate(1:2)).^2 );
 
end
SumError


%Find Hms :
currIndex=0;
 for i=2:size(pointsMonitor)
  currIndex=currIndex+1;
  Vector_Pm=pointsMonitor(i,:)-pointsMonitor(1,:);  
  Vector_Ps=pointssurface(i,:)-pointssurface(1,:);
  
  mat(currIndex,1:4)=[Vector_Pm(1),0,Vector_Pm(2),0];
  Bs(currIndex,1)=Vector_Ps(1);
  currIndex=currIndex+1;
  mat(currIndex,1:4)=[0,Vector_Pm(1),0,Vector_Pm(2)];
  Bs(currIndex,1)=Vector_Ps(2);
     
 end
 sol=mat\Bs;
 Hms=reshape(sol,2,2);
 Hms=[sol(1),sol(2);sol(3),sol(4)];
 t = mat*sol-Bs;
 totalError = sum( t.^2);
 
SumError=0;
for i=2:size(pointsMonitor)

  Vector_Pm=pointsMonitor(i,:)-pointsMonitor(1,:);  
  Vector_Ps=pointssurface(i,:)-pointssurface(1,:);
  Vs_Estimate=(Vector_Pm(1:2)*Hms);
  
  SumError=SumError+sum( (Vector_Ps(1:2)-Vs_Estimate(1:2)).^2 );
 
end
SumError
 
 
 