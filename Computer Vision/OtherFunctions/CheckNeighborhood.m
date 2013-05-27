function [ problemPoints ] = CheckNeighborhood( MapAllPixel ,WindowsSize,step,MaxDeltaLength,MaxDeltaSlope,Maxdist)
problemPoints=[];

n=size(MapAllPixel,1);
countproblemPoints=1;
countAll=0;
sumslope=0;
sumLength=0;
for i=1:n
    SrcPoint=[MapAllPixel(i,1) MapAllPixel(i,2)];
    DesPoint=getNextPointFromParameter([MapAllPixel(i,3) MapAllPixel(i,4)], [MapAllPixel(i,5) MapAllPixel(i,6) MapAllPixel(i,7) MapAllPixel(i,8)]);
    [Length Slope] = GetLineLenthAndSlope(SrcPoint,DesPoint);

     CountNeighborhood=0;
     CountNeighborhoodFar=0;
    for m=-WindowsSize:WindowsSize
        for k=-WindowsSize:WindowsSize
            currSrcPoint=[SrcPoint(1)+m*step SrcPoint(2)+k*step];
            [a ~]=find(MapAllPixel(:,1)==currSrcPoint(1));
            [c ~]=find(MapAllPixel(:,2)==currSrcPoint(2));
            curLineNumber=intersect(a,c);
            if isempty (curLineNumber)
                continue
            end
             curPoints = [SrcPoint;currSrcPoint];
             d = pdist(curPoints,'euclidean');
             if d>Maxdist
                 continue;
             end
            CurrDesPoint=getNextPointFromParameter([MapAllPixel(curLineNumber,3) MapAllPixel(curLineNumber,4)], [MapAllPixel(curLineNumber,5) MapAllPixel(curLineNumber,6) MapAllPixel(curLineNumber,7) MapAllPixel(curLineNumber,8)]);
            [curLength curSlope] = GetLineLenthAndSlope(currSrcPoint,CurrDesPoint);
             if isempty (curSlope)
                curSlope=0;
             end
           
             countAll=countAll+1;
            sumslope=sumslope+ abs(curSlope-Slope);
            sumLength=sumLength+ abs(curLength-Length);
            if  abs(curLength-Length)>MaxDeltaLength | abs(curSlope-Slope)>MaxDeltaSlope
                CountNeighborhoodFar=CountNeighborhoodFar+1;
            end
            
           
            CountNeighborhood=CountNeighborhood+1;
          
            
            
        end
    end
    if CountNeighborhoodFar==0
        
    elseif (CountNeighborhood /CountNeighborhoodFar) <= 2
        problemPoints(countproblemPoints,:)=SrcPoint;
        
        countproblemPoints=countproblemPoints+1;
    end
    
end
sumslope/countAll
sumLength/countAll
end

