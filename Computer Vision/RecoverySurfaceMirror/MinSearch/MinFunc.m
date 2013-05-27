function [ sum,Points3D ] = MinFunc( args,K,ImagePoints,RealPoints,multipleAdd )
x=args(1);
a=args(2);
b=args(3);
c=args(4);

R=ang2orth([a,b,c]);

Kinv=pinv(K);
for i=1:size(ImagePoints,1)
   kerenPoins(i,:)=(Kinv*ImagePoints(i,:)')';
  % kerenPoins(i,:)= kerenPoins(i,:)/norm( kerenPoins(i,:));
end
r1=R(1:3,1);
r2=R(1:3,2);


O=kerenPoins(1,:)*x;

O=O';

Points3D(1,:)=[O;1]';
Points3D(2,:)=[O + multipleAdd*r1*RealPoints(2,1);1]';
Points3D(3,:)=[((Points3D(2,1:3)') +multipleAdd* r2*RealPoints(3,2));1]';
Points3D(4,:)=[O + multipleAdd*r2*RealPoints(3,2);1]';
Points3D(5,:)=Points3D(1,:);  %just add the first point to the end of the array for draw square
sum=0;
for i=1:4
    newPoint=K*Points3D(i,1:3)';
    newPoint=newPoint/newPoint(3,1);
    delta=ImagePoints(i,:)-newPoint';
    sum=sum+norm(delta);
end

end

