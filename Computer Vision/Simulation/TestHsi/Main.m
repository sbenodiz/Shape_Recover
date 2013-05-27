clear
load('AllPointsForTests');
Hsi=[ 0.83967      0.20451;0.060907      -1.0111];
Hsi=Hsi.*(1/40.763); % the depth of ps
Hsi2=[ -0.8397   -0.2045;-0.0609    1.0111];

MyHsi=Hsi2;
SumError=0;
for i=2:size(pointsImage)

  Vector_Pi=pointsImage(i,:)-pointsImage(1,:);  
  Vector_Ps=pointssurface(i,:)-pointssurface(1,:);
  Vi_Estimate=(MyHsi*Vector_Ps(1:2)')';
  
  SumError=SumError+sum( (Vi_Estimate-Vector_Pi(1:2)).^2 );
 
end
SumError


%Find Hsi :
currIndex=0;
 for i=2:size(pointsImage)
  currIndex=currIndex+1;
  Vector_Pi=pointsImage(i,:)-pointsImage(1,:);  
  Vector_Ps=pointssurface(i,:)-pointssurface(1,:);
  
  mat(currIndex,1:4)=[Vector_Ps(1),Vector_Ps(2),0,0];
  Bs(currIndex,1)=Vector_Pi(1);
  currIndex=currIndex+1;
  mat(currIndex,1:4)=[0,0,Vector_Ps(1),Vector_Ps(2)];
  Bs(currIndex,1)=Vector_Pi(2);
     
 end
 sol=mat\Bs;
 Hsi=reshape(sol,2,2);
 Hsi=[sol(1),sol(2);sol(3),sol(4)];
 t = mat*sol-Bs;
 totalError = sum( t.^2);
 
SumError=0;
for i=2:size(pointsImage)

  Vector_Pi=pointsImage(i,:)-pointsImage(1,:);  
  Vector_Ps=pointssurface(i,:)-pointssurface(1,:);
  Vi_Estimate=(Hsi*Vector_Ps(1:2)')';
  SumError=SumError+sum( (Vi_Estimate-Vector_Pi(1:2)).^2 );
 
end
SumError
 
 
 