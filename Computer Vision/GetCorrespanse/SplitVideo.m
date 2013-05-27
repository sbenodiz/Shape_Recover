function [ScreenPoints,MirrorPoints,image] = SplitVideo( imageName )

movi = ReadAvi(imageName);
imagesc(movi(300).cdata)
[choosenY,choosenX]=ginput(4);
choosenX=floor(choosenX);
choosenY=floor(choosenY);
image=movi(100).cdata;
for im = 1:length(movi) 
    %flip the mirror
    movi(im).cdata(choosenX(3):choosenX(4),choosenY(3):choosenY(4),:)=flipdim(movi(im).cdata(choosenX(3):choosenX(4),choosenY(3):choosenY(4),:),2);
end
 
 %save two diffrent movie
  for im = 1:length(movi) 
      screenmovie(im).colormap=[];
      mirrormovie(im).colormap=[];
      screenmovie(im).cdata=movi(im).cdata(choosenX(1):choosenX(2),choosenY(1):choosenY(2),:);
      mirrormovie(im).cdata=movi(im).cdata(choosenX(3):choosenX(4),choosenY(3):choosenY(4),:);
  end

movie2avi(screenmovie,'screenmovie');
movie2avi(mirrormovie,'mirrormovie');

ScreenPoints=[choosenX(1),choosenY(1),choosenX(2),choosenY(2)];
MirrorPoints=[choosenX(3),choosenY(3),choosenX(4),choosenY(4)];

end

