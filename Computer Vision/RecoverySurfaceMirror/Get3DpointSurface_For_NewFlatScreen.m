function [ Points3D ] = Get3DpointSurface_For_NewFlatScreen( RealPoints,ImagePoints,InverseRTranspose,name)
M=zeros(8,9);

for i=1:size(ImagePoints,1)
    M((i*2)-1,1:3)=RealPoints(i,:);
    M((i*2)-1,7:9)=-RealPoints(i,:)*ImagePoints(i,1);
    M(i*2,4:6)=RealPoints(i,:);
    M(i*2,7:9)=-RealPoints(i,:)*ImagePoints(i,2);    
end


[U S V] = svd(M);
X = V(:,end);
H(1,:)=X(1:3,1)';
H(2,:)=X(4:6,1)';
H(3,:)=X(7:9,1)';

K=[413.333300000000,0,360.536967117290;
    0,438.857100000000,249.568615725655;
    0,0,1;];
% load('KK');
newRO=pinv(K)*H;

h1=newRO(1:3,1);
h2=newRO(1:3,2);

scaleFactor=(norm(h1)+norm(h2))/2;
newRO=newRO./scaleFactor;
r1=newRO(1:3,1);%/norm(h1);
r2=newRO(1:3,2);%/norm(h2);
r3=cross(r1,r2);
r3=r3/norm(r3);

R=[r1,r2,r3];



if InverseRTranspose
    RInv=R';
else
    RInv=pinv(R);
end
fprintf('\nfor: %s',name);
fprintf('\nr1*r2= %f',r1'*r2);
fprintf('\nr1*r3= %f',r1'*r3);
fprintf('\nr2*r3= %f',r2'*r3);
fprintf('\nnorm(r1)= %f',norm(r1));
fprintf('\nnorm(r2)= %f',norm(r2));
fprintf('\nnorm(r3)= %f',norm(r3));
fprintf('\n\n\n');



O=-RInv*newRO(1:3,3);
O=-(O'*RInv)';



multipleAdd=1;

Points3D(1,:)=[O;1]';
Points3D(2,:)=[O + multipleAdd*r1*RealPoints(4,1);1]';
Points3D(3,:)=[((Points3D(2,1:3)') +multipleAdd* r2*RealPoints(6,2));1]';
Points3D(4,:)=[O + multipleAdd*r2*RealPoints(6,2);1]';
 
Points3D(5,:)=Points3D(1,:);  %just add the first point to the end of the array for draw square
end

