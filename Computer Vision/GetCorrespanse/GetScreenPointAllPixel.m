function [ ScreenPoint ] = GetScreenPointAllPixel(mirrorPoint, MapCorrespondencePixel,kNearest )
%get a mirror point and return the screen point even if the mirror point
%don't exist in the MapCorrespondencePixel.
%kNearest- how mauch point need to be consider


[a ~]=find(MapCorrespondencePixel(:,3)==mirrorPoint(1));
[c ~]=find(MapCorrespondencePixel(:,4)==mirrorPoint(2));
curLineNumber=intersect(a,c);

if isempty(curLineNumber) % the point don't exsits in the map
   DontIncludeIdenty=1;
   %add temp row just for find the nearest points
   newrow=[0 0 mirrorPoint];
   MapCorrespondencePixel(length(MapCorrespondencePixel)+1,:)=newrow;
    
   pointsMirror=[MapCorrespondencePixel(:,3) MapCorrespondencePixel(:,4)];
   distanseMatrix=squareform(pdist(pointsMirror)); % for each m(i,j) is the distanse between the point i and j 
   Points=FindTheNireestPoints(mirrorPoint,distanseMatrix,MapCorrespondencePixel,kNearest,DontIncludeIdenty);
   T=[Points(1,1)-Points(3,1),Points(2,1)-Points(3,1);Points(1,2)-Points(3,2),Points(2,2)-Points(3,2)];
   X=pinv(T)*(mirrorPoint-Points(3,:))';
   X(3,1)=1-X(2,1)-X(1,1);
   
   isOutSideOfTriangle=0;
   for j=1:3
       if X(j,1)<0 || X(j,1)>1
           isOutSideOfTriangle=1;
       end
   end
   if isOutSideOfTriangle
       newX=mirrorPoint(1,:)./Points(1,:);
       PointOnSceenEstimate=GetScreenPoint(Points(1,:),MapCorrespondencePixel).*newX;  %% CHANGE THE -
       
   else
       PointOnSceenEstimate=GetScreenPoint(Points(1,:),MapCorrespondencePixel)*X(1) + GetScreenPoint(Points(2,:),MapCorrespondencePixel)*X(2)+ GetScreenPoint(Points(3,:),MapCorrespondencePixel)*X(3);
   end
       
   
   
   ScreenPoint=PointOnSceenEstimate;
    
    
    
else
    
    ScreenPoint=MapCorrespondencePixel(curLineNumber(1),1:2);

end
end
