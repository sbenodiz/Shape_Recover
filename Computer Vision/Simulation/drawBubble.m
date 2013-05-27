
function drawBubble (xcenter, ycenter,zcenter, radius, color, string,colorNum,drawCicle,FontSize)
if nargin==7
    drawCicle=1;
    FontSize=13;
end
if nargin==8
    
    FontSize=13;
end
% draw circle with input xcenter, ycenter, radius, color and text
angles = linspace(0, 2*pi, 40);
bubx = xcenter + (radius * cos(angles));
buby = ycenter + (radius * sin(angles));
bubz(1:40) = zcenter;
if drawCicle
    fill3(bubx, buby,bubz, color, 'EdgeColor', color);
end
text(xcenter, ycenter,zcenter, string, 'Color', colorNum, 'FontSize', FontSize, ...
       'FontWeight', 'normal', 'HorizontalAlignment', 'center')
   
end