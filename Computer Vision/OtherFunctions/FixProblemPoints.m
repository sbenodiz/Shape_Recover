function [ MapAllPixel oldProblemPoint ] = FixProblemPoints(movi, problemPoints, MapAllPixel,WindowSizeInput,IncludeIdentity,NormalizeMinimumFounded)

numOfPoints=size(problemPoints,1);
mincurrscore=Inf;
bestIndex=0;
for i=1:numOfPoints
    curPoint=problemPoints(i,:);
    for j=1:4
         [m,n,X] = GetNextPixel_parameters(movi,curPoint(1),curPoint(2),WindowSizeInput,IncludeIdentity,NormalizeMinimumFounded,[1 0 0 0],[],[],j);
         if m<1 | n<1
             continue
         end
         currscore=GetScoreForArrayAndPoints(movi,curPoint(1),curPoint(2),m,n,X);
         if currscore<mincurrscore
             mincurrscore=currscore;
             bestIndex=j;
         end
    end
    
     [m,n,X] = GetNextPixel_parameters(movi,curPoint(1),curPoint(2),WindowSizeInput,IncludeIdentity,NormalizeMinimumFounded,[1 0 0 0],[],[],bestIndex);
   
     [a ~]=find(MapAllPixel(:,1)==curPoint(1));
     [c ~]=find(MapAllPixel(:,2)==curPoint(2));
     curLineNumber=intersect(a,c);
     if isempty (curLineNumber)
        continue
     end
     
     if MapAllPixel(curLineNumber,3)~= m | MapAllPixel(curLineNumber,4)~=n
         text='change'
         oldProblemPoint=MapAllPixel(curLineNumber,1:8);
         MapAllPixel(curLineNumber,3:8)=[m n X']; 
      
     end
end

