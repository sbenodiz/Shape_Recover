function [ MapCorrespondencePixelNew ] = GetCoorespancePoint( numberOfFrames,TreshHold,TreshHoldErr,WindowsSize,mirrorMovie,screenMovie,MirrorPoints,ScreenPoints )
 Options.upright=true;
 Options.tresh=0.0002;
 Options.extended=false;
 numOfRows=0;
 countPoints=1;

 
  MapCorrespondencePixel=[0  0 0 0];
%for i = 1:length(mirrorMovie)
for i = 1:numberOfFrames 
  i
  screenImage=screenMovie(i).cdata;
  mirrorImage=zeros(size(screenImage));
  temp=mirrorMovie(i).cdata;
  [m,n,k]=size(temp);
  mirrorImage(1:m,1:n,1:k)=temp;  
  
  screenPts=OpenSurf(screenImage,Options);
  mirrorPts=OpenSurf(mirrorImage,Options);
  if size(mirrorPts,2)==1 || size(screenPts,2)==1 
    i
    continue;
  end

  % Put the landmark descriptors in a matrix
  screenD1 = reshape([screenPts.descriptor],64,[]); 
  mirrorD2 = reshape([mirrorPts.descriptor],64,[]); 
    err=zeros(1,length(screenPts));
  corScreen=1:length(screenPts); 
  corMirror=zeros(1,length(screenPts));
  for k=1:length(screenPts),
      distance=sum((mirrorD2-repmat(screenD1(:,k),[1 length(mirrorPts)])).^2,1);
      [err(k),corMirror(k)]=min(distance);
  end
% Sort matches on vector distance
  [errSorted, ind]=sort(err); 
  corScreenGlobal{i}=corScreen(ind);
  corMirrorGlobal{i}=corMirror(ind);
  screenPtsGlobal{i}=screenPts;
  mirrorPtsGlobal{i}=mirrorPts;
  errSortedGlobal{i}=errSorted;
 
  corScreen=corScreen(err<TreshHoldErr); 
  corMirror=corMirror(err<TreshHoldErr);
 
 % err(bestValue)
%    numberBroto=length(corMirror)
   for k=1:length(corMirror)
    
      newRow=[screenPts(corScreen(k)).x screenPts(corScreen(k)).y mirrorPts(corMirror(k)).x mirrorPts(corMirror(k)).y];
      newRow=floor(newRow);
      %[~,indx]=ismember(MapCorrespondencePixel,newRow,'rows');
      if ~isempty(GetScreenPoint(newRow(1,3:4),MapCorrespondencePixel))
          continue;
      end
      
      
%       countPoints=countPoints+1;
      numOfRows=numOfRows+1;
      MapCorrespondencePixel(numOfRows,:)=newRow;
   end
%    countPoints
  
end
 
for i=1:length(MapCorrespondencePixel)
    % fix the points to be match from the flip of the mirror
    MapCorrespondencePixel(i,1)=MapCorrespondencePixel(i,1)+ScreenPoints(2);
    MapCorrespondencePixel(i,3)=MirrorPoints(2)-(MapCorrespondencePixel(i,3)+MirrorPoints(2))+MirrorPoints(4);
    MapCorrespondencePixel(i,2)=MapCorrespondencePixel(i,2)+ScreenPoints(1);
    MapCorrespondencePixel(i,4)=MapCorrespondencePixel(i,4)+MirrorPoints(1);

end

 MapCorrespondencePixelNew=MapCorrespondencePixel;
 size(MapCorrespondencePixelNew)
    MapCorrespondencePixelNew=ClearPoints(MapCorrespondencePixelNew,TreshHold);

 % add points where there is no matches
%   MapCorrespondencePixelNew=AddPoints(MapCorrespondencePixelNew,corScreenGlobal,corMirrorGlobal,screenPtsGlobal,mirrorPtsGlobal,size(mirrorImage),WindowsSize,errSortedGlobal);
%  
%   %clear the flase matches                         
%   MapCorrespondencePixelNew=ClearPoints(MapCorrespondencePixelNew,TreshHold);
 
end

