function [m,n,X]=GetNextPixel_parameters(movi,x,y,WindowSizeInput,IncludeIdentity,NormalizeMinimumFounded,XFromInput,IgnoredPixels,IndexToAdd,IndexOfArray)
%the input is source pixel and is parameters(if he have). IgnoredPixels=
%which pixel to ignored (they give 0<  in the privios round),  
if nargin==6
    XFromInput=[1 0 0 0];
    XFromInput=XFromInput';
    IndexToAdd=[];
    IgnoredPixels=[];
    IndexOfArray=[];
elseif nargin==7
    IgnoredPixels=[];
    IndexToAdd=[];
    IndexOfArray=[];
elseif nargin==8
    IndexToAdd=[];
    IndexOfArray=[];
end
[o1,o2,resMatFromGetNextPixel]=GetNextPixel(movi,x,y,WindowSizeInput,IncludeIdentity,NormalizeMinimumFounded,XFromInput);

   %just for Upholstery  , find the  the best pixel from the priveos method.
    tempMat=resMatFromGetNextPixel(2:(WindowSizeInput*2)+2,2:(WindowSizeInput*2)+2);
 
    %find WindowSizeimum
    [~,ind] = max(tempMat(:));
    [m,n] = ind2sub(size(tempMat),ind); 
   

WindowSize=1;
FindMaxNeigboord=zeros(3,3);
%Ai- the quarter i in the matrix FindMaxNeigboord
for i=-WindowSize:WindowSize
    for j=-WindowSize:WindowSize
        % calc map of the suurond pixel of the best pixel - matrix 3*3 of the neighborhoods.
        FindMaxNeigboord(2+i,2+j)=resMatFromGetNextPixel(m+i+1,n+j+1);
       
    end
end
% find the best 3 neighborhoods from the 3*3 neighborhoods.
A(1)=FindMaxNeigboord(2,1)+FindMaxNeigboord(1,1)++FindMaxNeigboord(1,2);
A(2)=FindMaxNeigboord(1,2)+FindMaxNeigboord(1,3)++FindMaxNeigboord(2,3);
A(3)=FindMaxNeigboord(2,3)+FindMaxNeigboord(3,3)++FindMaxNeigboord(3,2);
A(4)=FindMaxNeigboord(3,2)+FindMaxNeigboord(3,1)++FindMaxNeigboord(2,1);

if isempty(IndexOfArray)
    MaxIndexArray=find(A==max(A));
    
else
    MaxIndexArray=IndexOfArray;
end




clear A;
%MaxIndex- represents the best 3 neighborhoods

MaxIndex=MaxIndexArray(1);  

if size(IgnoredPixels,1)<3
%     allPixels=[1 2 3 4];
%     DiffPixel = setdiff(allPixels,IgnoredPixels);
%     IgnoredPixels(size(IgnoredPixels,1)+1)=DiffPixel(1);
%     OnePixelToAdd=DiffPixel(1);
%     IndexToAdd(size(IndexToAdd,1)+1)=DiffPixel(1);

for i = 2:length(movi)

    movc = movi(i).cdata;
    movp = movi(i-1).cdata;
    
 for j=1:3 
  countCol=1;
   switch MaxIndex
   case 1
        
         if (o2-1<1|o1-1<1)
                 m=0;
                 n=0;
                 X=[1 0 0 0]';
                 return;
         end
         I4=double(movc(o1,o2,j));
         if   ~size(find(IgnoredPixels==1),1)>0
             Row(1,countCol)=double(movc(o1-1,o2-1,j))-I4;  
             countCol=countCol+1;
         end
         if   ~size(find(IgnoredPixels==2),1)>0
             Row(1,countCol)=double(movc(o1-1,o2,j))-I4;
             countCol=countCol+1;
         end
         if   ~size(find(IgnoredPixels==3),1)>0
             Row(1,countCol)= double(movc(o1,o2-1,j))-I4;  
             countCol=countCol+1;
         end
         
%          if   ~size(find(IgnoredPixels==4),1)>0
%              Row(1,countCol)=double(movc(o1,o2,j));  
%              countCol=countCol+1;
%          end
         %1,1 %1,2 %2,1 %2,2
   case 2
         if (o1-1<1|o2<1)
                 m=0;
                 n=0;
                 X=[1 0 0 0]';
                 return;
         end
         I4=double(movc(o1,o2+1,j));
         if   ~size(find(IgnoredPixels==1),1)>0
             Row(1,countCol)=double(movc(o1-1,o2,j))-I4;  
             countCol=countCol+1;
         end
         if   ~size(find(IgnoredPixels==2),1)>0
             Row(1,countCol)=double(movc(o1-1,o2+1,j))-I4;
             countCol=countCol+1;
         end
         if   ~size(find(IgnoredPixels==3),1)>0
             Row(1,countCol)= double(movc(o1,o2,j))-I4;  
             countCol=countCol+1;
         end
%          if    ~size(find(IgnoredPixels==4),1)>0
%              Row(1,countCol)=double(movc(o1,o2+1,j));  
%              countCol=countCol+1;
%          end
       
%         %1,2 %1,3 %2,2 %2,3    
   case 3      
           if (o2<1|o1<1)
                 m=0;
                 n=0;
                 X=[1 0 0 0]';
                 return;
           end
          I4=double(movc(o1+1,o2+1,j));
          if   ~size(find(IgnoredPixels==1),1)>0
             Row(1,countCol)=double(movc(o1,o2,j))-I4;  
             countCol=countCol+1;
         end
         if   ~size(find(IgnoredPixels==2),1)>0
             Row(1,countCol)=double(movc(o1,o2+1,j))-I4;
             countCol=countCol+1;
         end
         if   ~size(find(IgnoredPixels==3),1)>0
             Row(1,countCol)= double(movc(o1+1,o2,j))-I4;  
             countCol=countCol+1;
         end
%          if   ~size(find(IgnoredPixels==4),1)>0
%              Row(1,countCol)=double(movc(o1+1,o2+1,j))-double(movc(o1+1,o2+1,j));  
%              countCol=countCol+1;
%          end

%         %2,2 %2,3 %3,2 %3,3

   case 4
        if (o2-1<1|o1<1)
                 m=0;
                 n=0;
                 X=[1 0 0 0]';
                 return;
        end
         I4=double(movc(o1+1,o2,j));
         if   ~size(find(IgnoredPixels==1),1)>0
             Row(1,countCol)=double(movc(o1,o2-1,j))-I4;  
             countCol=countCol+1;
         end
         if   ~size(find(IgnoredPixels==2),1)>0
             Row(1,countCol)=double(movc(o1,o2,j))-I4;
             countCol=countCol+1;
         end
         if   ~size(find(IgnoredPixels==3),1)>0
             Row(1,countCol)= double(movc(o1+1,o2-1,j))-I4;  
             countCol=countCol+1;
         end
%          if   ~size(find(IgnoredPixels==4),1)>0
%              Row(1,countCol)=double(movc(o1+1,o2,j));  
%              countCol=countCol+1;
%          end
      
%         %2,1 %2,2 %3,1 %3,2

 
   end
 

       
          B(((i-1)*3)-3+j,1)=double(movp(x,y,j))-I4;
         A(((i-1)*3)+j-3,1:countCol-1)=Row;
  end
%   B(((i-1)*3)-2,1)=double(movp(x,y,1));
%   B(((i-1)*3)-1,1)=double(movp(x,y,2));
%   B(((i-1)*3),1)=double(movp(x,y,3));
 
end
  

X=A\B;
X(size(X,1)+1,1)=1-sum(X);
elseif size(IgnoredPixels,1)==3
    X=1;
  %  text = 'just one'
   
end
   if size(X,1)<4
        for i=1:size(IndexToAdd,1)
            valueToAssign=0;
%            if OnePixelToAdd==IndexToAdd(i)
%                valueToAssign=1-sum(X);
%            end
            
          if  size(X,1)>=IndexToAdd(i)
               X(size(X,1)+1,1)=valueToAssign;
           
          X(IndexToAdd(i):size(X,1))=circshift(X(IndexToAdd(i):size(X,1)),[1 1]);
          else
             X(size(X,1)+1,1)=valueToAssign;
          end
        end 
   end
    
if (min(X(1:3))<0)
    [m,n,X]=GetNextPixel_parameters(movi,x,y,WindowSizeInput,IncludeIdentity,NormalizeMinimumFounded,XFromInput,find(X(1:3)<=0),find(X(1:3)<=0),IndexOfArray);
else
if (X(4)<0)
    X(4)=0;
end
% if sum(X)==1
%    sum(X) 
% end
X=X.*(1/sum(X));

%return the left high corner index
switch MaxIndex
   case 1
      m=o1-1; n=o2-1; 
   case 2
      m=o1-1; n=o2;
      
   case 3      
      m=o1; n=o2;
   case 4
      m=o1; n=o2-1;
 end
 

end




end