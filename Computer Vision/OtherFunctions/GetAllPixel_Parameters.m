clc
clear all
close all
tic
imageName='FromImage_flat3.avi';
WindowSize=10;
step=10;
IncludeIdentity=1;
NormalizeMinimumFounded=1;
movi = ReadAvi(imageName);
[row,col,~]=size( movi(1).cdata);

[MapAllPixel, problemPoints ] = GetAllPixelsMap( imageName,movi,WindowSize,step );

[MapAllPixel oldProblemPoint]=FixProblemPoints(movi, problemPoints, MapAllPixel,WindowSize,IncludeIdentity,NormalizeMinimumFounded);
[numOfPoints,~]=size(MapAllPixel);
figure,imshow(movi(1).cdata)
for j=1:numOfPoints
    hold on

 p1=[MapAllPixel(j,1),MapAllPixel(j,2)];
 
 p2=getNextPointFromParameter([MapAllPixel(j,3) MapAllPixel(j,4)],[MapAllPixel(j,5) MapAllPixel(j,6) MapAllPixel(j,7) MapAllPixel(j,8)]);
 
 plot([p1(2),p2(2)],[p1(1),p2(1)],'Color','r','LineWidth',2)
 
 plot(p2(2),p2(1),'^','markerfacecolor',[1 0 0]);
 if isempty(problemPoints)
     continue;
 end
 
 [a ~]=find(problemPoints(:,1)==p1(1));
 [c ~]=find(problemPoints(:,2)==p1(2));
 curLineNumber=intersect(a,c);
 if ~isempty (curLineNumber)
     plot(problemPoints(curLineNumber,2),problemPoints(curLineNumber,1),'o','Color','w');          
 end

end

for j=1:size(oldProblemPoint,1)
  p1=[oldProblemPoint(j,1),oldProblemPoint(j,2)];
 
 p2=getNextPointFromParameter([oldProblemPoint(j,3) oldProblemPoint(j,4)],[oldProblemPoint(j,5) oldProblemPoint(j,6) oldProblemPoint(j,7) oldProblemPoint(j,8)]);
 
 plot([p1(2),p2(2)],[p1(1),p2(1)],'Color','y','LineWidth',2)
 
 plot(p2(2),p2(1),'^','markerfacecolor',[0 0 1]);
    
end


toc
