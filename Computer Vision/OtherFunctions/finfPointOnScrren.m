function [Xscreen,Yscreen]= finfPointOnScrren(currx,curry,movi,XPScrren,YPScrren)
for i = 2:length(movi)
    movi(i).cdata=  diff(movi(i).cdata);
end


figure,imshow(movi(1).cdata)

diffMatrix=zeros(size(movi(1).cdata(:,:,1)));
for i = 2:length(movi)
   movc = movi(i).cdata;
     
     
  for k=XPScrren(1):XPScrren(2)
      for m=YPScrren(1):YPScrren(2)
          diffPix=0;
          for t=1:3
              diffPix =diffPix+ abs(double(movc(currx,curry,t))-double(movc(k,m,t)));
          end
          diffMatrix(k,m)=diffMatrix(k,m)+diffPix;
         
      end
  end

end



[~,ind] = max(diffMatrix(:));
[Xscreen,Yscreen] = ind2sub(size(diffMatrix),ind); 


end