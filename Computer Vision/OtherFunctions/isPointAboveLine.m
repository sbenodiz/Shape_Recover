function isAboveLine=isPointAboveLine(a,b,c)
% Where a = line point 1; b = line point 2; c = point to check against.
% If the formula is equal to 0 points are colinear.
% If the line is horizontal, then this returns true if the point is above
% the line.
% public bool isLeft(Point a, Point b, Point c){
%      return ((b.x - a.x)*(c.y - a.y) - (b.y - a.y)*(c.x - a.x)) > 0;
% }
%return 0 below 1-above
if ((b(1)-a(1))*(c(2)-a(2))-(b(2)-a(2))*(c(1)-a(1)))>0
    isAboveLine=1;
else
    isAboveLine=0;
end




end