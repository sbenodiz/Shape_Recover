clc
clear all
close all
tic
imageName='FromImage_flat4.avi';
if (strcmp(imageName,'FromImage4.avi'))
    thresholdRound=5;
    thresholdGlobal=75;
elseif (strcmp(imageName,'FromImage6.avi'))
    thresholdGlobal=70;
    thresholdRound=4;
elseif (strcmp(imageName,'FromImage_flat.avi'))
    thresholdGlobal=40;
    thresholdRound=8;
elseif (strcmp(imageName,'FromImage_flat2.avi'))
    thresholdGlobal=40;
    thresholdRound=8;
elseif (strcmp(imageName,'FromImage_flat3.avi'))
    thresholdGlobal=50;
    thresholdRound=8;
elseif (strcmp(imageName,'FromImage_flat4.avi')) 
    thresholdGlobal=50;
    thresholdRound=8;
end

numberOfReferncePoint=20;
WindowSize=10;
step=10;
MaxValue=1;
movi = ReadAvi(imageName);
imagesc(movi(1).cdata)
% [choosenY,choosenX]=ginput(4);
% 
% 
% 
% 
% choosenX=floor(choosenX);
% choosenY=floor(choosenY);
% [MapAllPixel, problemPoints ] = GetAllPixelsMap( imageName,movi,WindowSize,step );
% % save('MapAllPixel','MapAllPixel');
% % save('problemPoints','problemPoints');
% save('Data');
load('Data');

% load('MapAllPixel');
% load('problemPoints');
numMotionPixel=size(MapAllPixel,1);


% for im = 1:length(movi) 
%     
%     u= movi(im).cdata;
%     movi(im).cdata=Dx_plus(u);
% 
% end

 for im = 1:length(movi) 
    %flip the mirror
    movi(im).cdata(choosenX(3):choosenX(4),choosenY(3):choosenY(4),:)=flipdim(movi(im).cdata(choosenX(3):choosenX(4),choosenY(3):choosenY(4),:),2);
   % movi(im).cdata=derivative5(movi(im).cdata,'x');
 %  movi(im).cdata=diff(movi(im).cdata);
   % movi(im).cdata=Dx_plus(movi(im).cdata);
   %  movi(im).cdata=coloredges(movi(im).cdata);
 end
 %load('movi');
 %implay(movi);
 

 %save two diffrent movie
%   for im = 1:length(movi) 
%        screenmovie(im).colormap=[];
%        mirrormovie(im).colormap=[];
%       screenmovie(im).cdata=movi(im).cdata(choosenX(1):choosenX(2),choosenY(1):choosenY(2),:);
%       mirrormovie(im).cdata=movi(im).cdata(choosenX(3):choosenX(4),choosenY(3):choosenY(4),:);
%   end
% 
% movie2avi(screenmovie,'screenmovie');
% movie2avi(mirrormovie,'mirrormovie');




%665
for i=1:numMotionPixel
    currx=MapAllPixel(i,1);
    curry=MapAllPixel(i,2);
    if  currx>choosenX(1) &&  currx<choosenX(2)  &&  curry>choosenY(1)  &&  curry<choosenY(2) 
        %screen
        
        
    elseif  currx>choosenX(3) &&  currx<choosenX(4)  &&  curry>choosenY(3)  &&  curry<choosenY(4) 
        %mirror
        
        [a ~]=find(problemPoints(:,1)==currx);
        [c ~]=find(problemPoints(:,2)==curry);
        curLineNumber=intersect(a,c);
        [sizecurLineNumber, ~]=size(curLineNumber);
        if sizecurLineNumber==0
           %The point is not problem point
            [c ~]=find(MapAllPixel(:,2)==curry);
            [a ~]= find(c(:)==i);
            a=a+1;
           [sizec,~]= size(c);
            if (a<sizec)
                numberNextRow=c(a); %number of next row in MapAllPixel
                searchForSquareInScreen(movi,MapAllPixel,problemPoints,choosenX,choosenY,[currx,curry],[MapAllPixel(i,3),MapAllPixel(i,4)],[MapAllPixel(numberNextRow,1),MapAllPixel(numberNextRow,2)],[MapAllPixel(numberNextRow,3),MapAllPixel(numberNextRow,4)]);
            end
        end

    end
    
    
    
    
end


figure,imshow(movi(1).cdata)




toc