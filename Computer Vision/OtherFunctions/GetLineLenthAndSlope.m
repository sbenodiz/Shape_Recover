function [length slope] = GetLineLenthAndSlope( srcPoint,desPoint )
    length=sqrt(((srcPoint(1)-desPoint(1))^2) + ((srcPoint(2)-desPoint(2))^2));
    slope=atan2(abs(srcPoint(2)-desPoint(2)),abs((srcPoint(1)-desPoint(1))));
%     if (srcPoint(1)-desPoint(1))==0
%         slope=[];
%     else
%         slope=(srcPoint(2)-desPoint(2))/(srcPoint(1)-desPoint(1));
%     end
    
end

