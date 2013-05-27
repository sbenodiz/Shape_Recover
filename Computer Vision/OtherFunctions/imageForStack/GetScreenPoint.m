function ScreenPoint = GetScreenPoint( mirrorPoint, MapCorrespondencePixel)
%GETSCREENPOINT Summary of this function goes here
%   Detailed explanation goes here
if nargin==1
     ScreenPoint=[];
     return;
end
if isempty(MapCorrespondencePixel)
     ScreenPoint=[];
     return;
end
[a ~]=find(MapCorrespondencePixel(:,3)==mirrorPoint(1));
[c ~]=find(MapCorrespondencePixel(:,4)==mirrorPoint(2));
curLineNumber=intersect(a,c);

if isempty(curLineNumber) 
    ScreenPoint=[];
else
    
    ScreenPoint=MapCorrespondencePixel(curLineNumber(1),1:2);

end
end

