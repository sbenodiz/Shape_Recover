function [ score ] = GetScoreForArrayAndPoints( movi,x,y,desX,desY,X)

XFromInput=[1 0 0 0]; 
XFromInput=XFromInput';
sum=0;
for i = 2:length(movi)

    movc = movi(i).cdata;
    movp = movi(i-1).cdata;
    
    movp_r1=(movp(x,y,1)*XFromInput(1))+(movp(x,y+1,1)*XFromInput(2))+(movp(x+1,y,1)*XFromInput(3))+(movp(x+1,y+1,1)*XFromInput(4));
    movp_g2=(movp(x,y,2)*XFromInput(1))+(movp(x,y+1,2)*XFromInput(2))+(movp(x+1,y,2)*XFromInput(3))+(movp(x+1,y+1,2)*XFromInput(4));
    movp_b3=(movp(x,y,3)*XFromInput(1))+(movp(x,y+1,3)*XFromInput(2))+(movp(x+1,y,3)*XFromInput(3))+(movp(x+1,y+1,3)*XFromInput(4));
    
    movc_r1=(movc(desX,desY,1)*X(1))+(movc(desX,desY+1,1)*X(2))+(movc(desX+1,desY,1)*X(3))+(movc(desX+1,desY+1,1)*X(4));
    movc_g2=(movc(desX,desY,2)*X(1))+(movc(desX,desY+1,2)*X(2))+(movc(desX+1,desY,2)*X(3))+(movc(desX+1,desY+1,2)*X(4));
    movc_b3=(movc(desX,desY,3)*X(1))+(movc(desX,desY+1,3)*X(2))+(movc(desX+1,desY,3)*X(3))+(movc(desX+1,desY+1,3)*X(4));

    diffPix = abs(double(movp_r1)-double(movc_r1))+abs(double(movp_g2)-double(movc_g2))+abs( double(movp_b3)-double(movc_b3));
    sum=sum+diffPix;               
          
end
score=sum;
  
    
end
