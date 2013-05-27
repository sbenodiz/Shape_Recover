function [ sumError,Points3D ] = MinFuncMulti( args,K,ImagePoints,RealPoints,multipleAdd )
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
Points3D(2,:)=[O + multipleAdd*r1*RealPoints(5,1);1]';
Points3D(3,:)=[((Points3D(2,1:3)') +multipleAdd* r2*RealPoints(8,2));1]';
Points3D(4,:)=[O + multipleAdd*r2*RealPoints(8,2);1]';
Points3D(5,:)=Points3D(1,:);  %just add the first point to the end of the array for draw square



Points3DForOptim(1,:)=[O;1]';

Points3DForOptim(2,:)=[O + multipleAdd*r1*RealPoints(2,1);1]';
Points3DForOptim(3,:)=[O + multipleAdd*r1*RealPoints(3,1);1]';
Points3DForOptim(4,:)=[O + multipleAdd*r1*RealPoints(4,1);1]';
Points3DForOptim(5,:)=[O + multipleAdd*r1*RealPoints(5,1);1]';


Points3DForOptim(6,:)=[((Points3DForOptim(5,1:3)') +multipleAdd* r2*RealPoints(6,2));1]';
Points3DForOptim(7,:)=[((Points3DForOptim(5,1:3)') +multipleAdd* r2*RealPoints(7,2));1]';
Points3DForOptim(8,:)=[((Points3DForOptim(5,1:3)') +multipleAdd* r2*RealPoints(8,2));1]';



Points3DForOptim(16,:)=[O + multipleAdd*r2*RealPoints(16,2);1]';
Points3DForOptim(15,:)=[O + multipleAdd*r2*RealPoints(15,2);1]';
Points3DForOptim(14,:)=[O + multipleAdd*r2*RealPoints(14,2);1]';
Points3DForOptim(13,:)=[O + multipleAdd*r2*RealPoints(13,2);1]';
Points3DForOptim(12,:)=[O + multipleAdd*r2*RealPoints(12,2);1]';

Points3DForOptim(11,:)=[(Points3DForOptim(12,1:3)') + multipleAdd*r1*RealPoints(11,1);1]';
Points3DForOptim(10,:)=[(Points3DForOptim(12,1:3)') + multipleAdd*r1*RealPoints(10,1);1]';
Points3DForOptim(9,:)=[(Points3DForOptim(12,1:3)') + multipleAdd*r1*RealPoints(9,1);1]';


sumError=0;
for i=1:16
    newPoint=K*Points3DForOptim(i,1:3)';
    newPoint=newPoint/newPoint(3,1);
    delta=ImagePoints(i,:)-newPoint';
    sumError=sumError+sum(delta.^2);
end

end

