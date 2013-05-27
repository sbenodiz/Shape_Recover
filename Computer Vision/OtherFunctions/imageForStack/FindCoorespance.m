 clear;
 clc;
 mirrorMovie = (ReadAvi('mirrormovie.avi'));
 screenMovie = (ReadAvi('screenmovie.avi'));

 bestValue=4;
 TreshHold=6;
 TreshHoldErr=0.09;
 Options.upright=true;
 Options.tresh=0.0002;
 WindowsSize=20;
 Options.extended=false;
 numOfRows=0;
 countPoints=1;
 MapCorrespondencePixel=[0  0 0 0];
%for i = 1:length(mirrorMovie)
for i = 1:150
  screenImage=screenMovie(i).cdata;
  mirrorImage=zeros(size(screenImage));
  temp=mirrorMovie(i).cdata;
  [m,n,k]=size(temp);
  mirrorImage(1:m,1:n,1:k)=temp;  
  
  screenPts=OpenSurf(screenImage,Options);
  mirrorPts=OpenSurf(mirrorImage,Options);

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
   for k=1:length(corMirror)
    
      newRow=[screenPts(corScreen(k)).x screenPts(corScreen(k)).y mirrorPts(corMirror(k)).x mirrorPts(corMirror(k)).y];
      newRow=floor(newRow);
      %[~,indx]=ismember(MapCorrespondencePixel,newRow,'rows');
      if ~isempty(GetScreenPoint(newRow(1,3:4),MapCorrespondencePixel))
          continue;
      end
      
      
      countPoints=countPoints+1;
      numOfRows=numOfRows+1;
      MapCorrespondencePixel(numOfRows,:)=newRow;
   end
  
end
  %%%%%%%%%%%
  %just take the good frame
  screenImage=screenMovie(80).cdata;
  mirrorImage=zeros(size(screenImage));
  temp=mirrorMovie(80).cdata;
  [m,n,k]=size(temp);
  mirrorImage(1:m,1:n,1:k)=temp;  
  %%%%%%%%%
  countPoints-1
% Show both images
  I = zeros([size(screenImage,1) size(screenImage,2)*2 size(screenImage,3)]);
  I(:,1:size(screenImage,2),:)=screenImage; I(:,size(screenImage,2)+1:size(screenImage,2)+size(mirrorImage,2),:)=mirrorImage;
  figure, imshow(I/255); hold on;
  % Show the best matches
 for i=1:length(MapCorrespondencePixel),
      c=rand(1,3);
      plot([MapCorrespondencePixel(i,1) MapCorrespondencePixel(i,3)+size(screenImage,2)],[MapCorrespondencePixel(i,2) MapCorrespondencePixel(i,4)],'-','Color',c)
     % plot([MapCorrespondencePixel(i,1) MapCorrespondencePixel(i,3)+size(screenImage,2)],[MapCorrespondencePixel(i,2) MapCorrespondencePixel(i,4)],'o','Color',c)
 end
 %
 
 MapCorrespondencePixelNew=AddPoints(MapCorrespondencePixel,corScreenGlobal,corMirrorGlobal,screenPtsGlobal,mirrorPtsGlobal,size(mirrorImage),WindowsSize,errSortedGlobal);
 figure, imshow(I/255); hold on;
 for i=1:length(MapCorrespondencePixelNew),
      c=rand(1,3);
      plot([MapCorrespondencePixelNew(i,1) MapCorrespondencePixelNew(i,3)+size(screenImage,2)],[MapCorrespondencePixelNew(i,2) MapCorrespondencePixelNew(i,4)],'-','Color',c)
     % plot([MapCorrespondencePixel(i,1) MapCorrespondencePixel(i,3)+size(screenImage,2)],[MapCorrespondencePixel(i,2) MapCorrespondencePixel(i,4)],'o','Color',c)
 end       
                         
 MapCorrespondencePixelNew=ClearPoints(MapCorrespondencePixelNew,TreshHold);
 
  % Show the best matches
 figure, imshow(I/255); hold on;
 for i=1:length(MapCorrespondencePixelNew),
      c=rand(1,3);
      plot([MapCorrespondencePixelNew(i,1) MapCorrespondencePixelNew(i,3)+size(screenImage,2)],[MapCorrespondencePixelNew(i,2) MapCorrespondencePixelNew(i,4)],'-','Color',c)
     % plot([MapCorrespondencePixel(i,1) MapCorrespondencePixel(i,3)+size(screenImage,2)],[MapCorrespondencePixel(i,2) MapCorrespondencePixel(i,4)],'o','Color',c)
 end
 
 length(MapCorrespondencePixelNew)
 
 
 

