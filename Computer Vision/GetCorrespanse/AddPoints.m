function MapCorrespondencePixelNew=AddPoints(MapCorrespondencePixel,corScreenGlobal,corMirrorGlobal,screenPtsGlobal,mirrorPtsGlobal,sizeMirror,WindowsSize,errSortedGlobal)


TreshHoldError=0.1;  
kNearest=3;
TrashHold=20;
IncludeIdenty=1;
row=sizeMirror(1);
col=sizeMirror(2);


count=1;
% numOfPoints=round((row/step)*(col/step));
% MapAllPixel=zeros(numOfPoints,8);
for x=1:WindowsSize:row
    for y=1:WindowsSize:col
        currPoint=[x y];
        [a ~]=find(MapCorrespondencePixel(:,3)==currPoint(1));
        [c ~]=find(MapCorrespondencePixel(:,4)==currPoint(2));
        curLineNumber=intersect(a,c);
        if isempty(curLineNumber)
            %add temp row just for find the nearest points
            newrow=[0 0 x y];
            MapCorrespondencePixel(length(MapCorrespondencePixel)+1,:)=newrow;
        end
        pointsMirror=[MapCorrespondencePixel(:,3) MapCorrespondencePixel(:,4)];
        distanseMatrix=squareform(pdist(pointsMirror)); % for each m(i,j) is the distanse between the point i and j 
        
        
        
        PointsNireest=FindTheNireestPoints(currPoint,distanseMatrix,MapCorrespondencePixel,kNearest,IncludeIdenty);
        dis=sqrt(sum((currPoint-PointsNireest(kNearest,:)).^2));
        if dis>TrashHold 
            problemPoints(count,:)=[x y];
            count=count+1;
            
        end
        if isempty(curLineNumber)
           MapCorrespondencePixel(length(MapCorrespondencePixel),:)=[];
        end
    end

end

numOfRows=length(MapCorrespondencePixel);
% err(bestValue)
for i=1:length(corMirrorGlobal)
    corMirror=corMirrorGlobal{i};
    corScreen=corScreenGlobal{i};
    screenPts=screenPtsGlobal{i};
    mirrorPts=mirrorPtsGlobal{i};
    errSorted=errSortedGlobal{i};
   for k=1:length(corMirror)
       currPoint=[mirrorPts(corMirror(k)).x mirrorPts(corMirror(k)).y];
       
       if errSorted(k)>TreshHoldError
           continue
       end
       foundInProblemPoints=0;
       for t=1:length(problemPoints)
             dis=sqrt(sum((currPoint-problemPoints(t,:)).^2));
             if dis<TrashHold 
                 foundInProblemPoints=1;
                 break;
             end
       end
       if foundInProblemPoints
           newRow=[screenPts(corScreen(k)).x screenPts(corScreen(k)).y mirrorPts(corMirror(k)).x mirrorPts(corMirror(k)).y];
           newRow=floor(newRow);
      %[~,indx]=ismember(MapCorrespondencePixel,newRow,'rows');
           if ~isempty(GetScreenPoint(newRow(1,3:4),MapCorrespondencePixel))
               continue;
           end
           
           numOfRows=numOfRows+1;
           MapCorrespondencePixel(numOfRows,:)=newRow;
       end
      
   end
  

end
MapCorrespondencePixelNew=MapCorrespondencePixel;





