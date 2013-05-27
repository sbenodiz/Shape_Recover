function newPoint = getNextPointFromParameter( nextPoint,parameters )

  newPoint=[(nextPoint(1,1)*parameters(1,1))+(nextPoint(1,1)*parameters(1,2))+((nextPoint(1,1)+1)*parameters(1,3))+((nextPoint(1,1)+1)*parameters(1,4)) (nextPoint(1,2)*parameters(1,1))+((nextPoint(1,2)+1)*parameters(1,2)) + (nextPoint(1,2)*parameters(1,3))+((nextPoint(1,2)+1)*parameters(1,4))];

end

