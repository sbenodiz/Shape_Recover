function im = motion(A,B)

    i =A;
%  figure(1),imshow(i)
   % i=255*uint8(edge(rgb2gray(i),'canny'));
  
  
    j = B;
%  figure(2),imshow(j)
 
   
    
%     im=imabsdiff(i,j);
          im=abs(i-j);

   % im(im<threshold)=0;
 %   im(im>=threshold)=255;

  

