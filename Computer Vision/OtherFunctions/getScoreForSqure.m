function score=getScoreForSqure(movi,MapAllPixel,problemPoints,UpperPointMirror,LowerPointMirror,UpperPointScreen,LowerPointScreen)
         
            
            
%             
% %             
% %             
%             figure,imshow(movi(1).cdata)
%             hold on
%             plot(UpperPointMirror(1,2),UpperPointMirror(1,1),'^','markerfacecolor',[0 0 1]);
%             plot(UpperPointMirror(1,4),UpperPointMirror(1,3),'^','markerfacecolor',[0 0 1]);
%             plot(LowerPointMirror(1,2),LowerPointMirror(1,1),'^','markerfacecolor',[0 0 1]);
%             plot(LowerPointMirror(1,4),LowerPointMirror(1,3),'^','markerfacecolor',[0 0 1]);
%             plot(UpperPointScreen(1,2),UpperPointScreen(1,1),'^','markerfacecolor',[0 0 1]);
%             plot(UpperPointScreen(1,4),UpperPointScreen(1,3),'^','markerfacecolor',[0 0 1]);
%             plot(LowerPointScreen(1,2),LowerPointScreen(1,1),'^','markerfacecolor',[0 0 1]);
%             plot(LowerPointScreen(1,4),LowerPointScreen(1,3),'^','markerfacecolor',[0 0 1]);
            
  A=[UpperPointMirror(1,1:2);UpperPointMirror(1,3:4);LowerPointMirror(1,1:2);LowerPointMirror(1,3:4)];
  b=[UpperPointScreen(1,1:2);UpperPointScreen(1,3:4);LowerPointScreen(1,1:2);LowerPointScreen(1,3:4)];
  H=A\b;
%   testRes=A*H;
%   theResOk=1;
%   for i=1:4
%       for j=1:2
%           if testRes(i,j)~=0
%               theResOk=0;
%           end
%       end
%   end
%   theResOk
  
  
  %move on the mirror index
  MinX=UpperPointMirror(1);
  if MinX>UpperPointMirror(3)
      MinX=UpperPointMirror(3);
  end
  MaxY=UpperPointMirror(4);
  if MaxY<LowerPointMirror(4)
      MaxY=LowerPointMirror(4);
  end
  MaxX=LowerPointMirror(1);
  if MaxX<LowerPointMirror(3)
      MaxX=LowerPointMirror(3);
  end
  MinY=UpperPointMirror(2);
  if MinY>LowerPointMirror(2)
      MinY=LowerPointMirror(2);
  end
  
  %flip coulmn
  countNumOnMirror=0;
  globalSum=0;
  for numFrame = 1:length(movi)
        for i=MinX:MaxX
            for j=MinY:MaxY
                %check if the point is between the lines on 
                if ~isPointAboveLine(UpperPointMirror(1,1:2),UpperPointMirror(1,3:4),[i,j])
                    if isPointAboveLine(LowerPointMirror(1,1:2),LowerPointMirror(1,3:4),[i,j])
                        countNumOnMirror=countNumOnMirror+1;
                        pointonMirror=[i,j];
                        pointOnScreen=pointonMirror*H;
                        pointOnScreen=floor(pointOnScreen);
                        diffPix=abs(double(movi(numFrame).cdata(pointOnScreen(1),pointOnScreen(2),:))-double(movi(numFrame).cdata(pointonMirror(1),pointonMirror(2),:)));
                        diffPixSum=sum(diffPix);
                        globalSum=globalSum+diffPixSum;
                    end
                end
            end
        end   
  end
           
 
  
  
            
  score=globalSum/countNumOnMirror;          
            
            
            
            
            
end