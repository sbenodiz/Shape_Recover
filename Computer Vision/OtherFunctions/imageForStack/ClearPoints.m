function newPoints=ClearPoints(MapCorrespondencePixel,TrashHold)
    IncludeIdenty=1;
    kNearest=3;
    pointsMirror=[MapCorrespondencePixel(:,3) MapCorrespondencePixel(:,4)];
    distanseMatrix=squareform(pdist(pointsMirror)); % for each m(i,j) is the distanse between the point i and j 

    indexToReturn=ones(length(MapCorrespondencePixel),1);
    for i=1:length(MapCorrespondencePixel)
    
    
      
        currPoint=MapCorrespondencePixel(i,3:4);

        Points=FindTheNireestPoints(currPoint,distanseMatrix,MapCorrespondencePixel,kNearest,IncludeIdenty);

        T=[Points(1,1)-Points(3,1),Points(2,1)-Points(3,1);Points(1,2)-Points(3,2),Points(2,2)-Points(3,2)];
        X=pinv(T)*(currPoint-Points(3,:))';
        X(3,1)=1-X(2,1)-X(1,1);


        %calc screen Point
        PointOnSceenEstimate=GetScreenPoint(Points(1,:),MapCorrespondencePixel)*X(1) + GetScreenPoint(Points(2,:),MapCorrespondencePixel)*X(2)+ GetScreenPoint(Points(3,:),MapCorrespondencePixel)*X(3);
        PointOnSceenReal=GetScreenPoint(currPoint,MapCorrespondencePixel);
        dis=sqrt(sum((PointOnSceenReal-PointOnSceenEstimate).^2));
        if dis>TrashHold 
            indexToReturn(i)=0;
            
        end
      
    end
    newPoints=MapCorrespondencePixel(logical(indexToReturn),:);
    
    
end