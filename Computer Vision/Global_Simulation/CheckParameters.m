function [sumError] = CheckParameters(args,AllData,K,Points3DScreen,pointOnMirror)
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
% args(4)=args(3);
% delta=1-(args(1)^2+args(2)^2);
% if delta<0
%     numOfPoints=0;
%     sumError=Inf;
%     return
% end
% args(3)=sqrt(delta);

args(4)=pointOnMirror*args';

aGuess=args(1);
bGuess=args(2);
cGuess=args(3);
dGuess=args(4);

%  figure,imshow(movi(1).cdata);
%  hold on
numOfPoints=0;
sumError=0;
[n,~]=size(AllData);
for i=1:n

        
        pMiror1=AllData(i,1:3);
        pMiror2=AllData(i,4:6);
        pScreen1=AllData(i,7:9);
        pScreen2=AllData(i,10:12);
        %%%%%% get a,b,c seconed order approximtion and s -depth
        a=0; %plane
        b=0; %plane
        c=0; %plane

        s=GetS( aGuess,bGuess,cGuess,dGuess,pMiror1,K); %calc s from the plane equation;
    
        if 0==s % s can't be 0.
            sumError=Inf;
            numOfPoints=-1;
            return;
        end
        %%%%%%
        sumError=sumError+CheckPoint(pMiror1 ,pMiror2,pScreen1,pScreen2,a,b,c,s,K,Points3DScreen);
%drawBubble(pMiror1(1),pMiror1(2),pMiror1(3),1,'g','.','r',0,10);
        numOfPoints=numOfPoints+1;
   
end



end

