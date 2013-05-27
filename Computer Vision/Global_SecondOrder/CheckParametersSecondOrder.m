function [sumError,numOfPoints] = CheckParametersSecondOrder(args,AllData,K,Points3DScreen,equation)
%%%%%
%args is the guess parameters of the plane (4 parameters)
%movi- is the video, MapCorrespondencePixel-the key points between the
%screen and the mirror, stepMirror- the step to move in each round,
%FirstPointmirror- SecondPointmirror - is the frame of the mirror. K-
%calibration matrix, Points3DScreen- the 3D oints of the screen
%
%
%
%%%%
% args=[args(1),args(2),args(3),0,0,0,args(4),args(5),args(6),args(7)];
% args
x1=args(1);
y1=args(2);
z1=args(3);
r=args(4);
% r=5.08;
args=[1,1,1,0,0,0,-x1,-y1,-z1,x1^2+y1^2+z1^2-r^2];


% aGuess=args(1);
% bGuess=args(2);
% cGuess=args(3);
% dGuess=args(4);
% args=[0,0,0,0,0,0,aGuess,bGuess,cGuess,dGuess];


disp('Iteration');

tic
numOfPoints=0;
sumError=0;
[n,~]=size(AllData);
for i=1:n
    
        
        
        pMiror1=AllData(i,1:3);
        pMiror2=AllData(i,4:6);
        pScreen1=AllData(i,7:9);
        pScreen2=AllData(i,10:12);

        
        currPoint=GetIntersectionPointQuadricSurface(args,pMiror1,K,equation); %calc s from the plane equation;
        
        s=currPoint(3);
%         s=GetS( aGuess,bGuess,cGuess,dGuess,pMiror1,K); %calc s from the plane equation;

        if 0==s % s can't be 0.
            s=0.0000000001;
          %  sumError=sumError+1;
        end
        %%%%%%
        
        sumError=sumError+CheckPoint(args,pMiror1 ,pMiror2,pScreen1,pScreen2,s,K,Points3DScreen);
        
%drawBubble(pMiror1(1),pMiror1(2),pMiror1(3),1,'g','.','r',0,10);
        numOfPoints=numOfPoints+1;
        
   
end
sumError
toc

end

