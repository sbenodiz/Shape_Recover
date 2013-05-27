function [m,n,ResultMat]=GetNextPixel(movi,x,y,WindowSize,IncludeIdentity,NormalizeMinimumFounded,XFromInput)
%get the source pixel and find the best pixel that mach to this pixel in
%the next frame. the function check for each couple of frames.
%the input can be a combination of 4 pixeles.
%the output is the dest pixel and the score of the negiboord pixeles.
if nargin==6
    XFromInput=[1 0 0 0];
    XFromInput=XFromInput';
end

[row,col,~]=size( movi(1).cdata);
thresholdRound=5;
WindowSize=WindowSize+1; % just for Upholstery
diffMat=zeros(WindowSize*2+1,WindowSize*2+1);
ResultMat=zeros(WindowSize*2+1,WindowSize*2+1);

for i = 2:length(movi)

    movc = movi(i).cdata;
    movp = movi(i-1).cdata;
    
    movp_r1=(movp(x,y,1)*XFromInput(1))+(movp(x,y+1,1)*XFromInput(2))+(movp(x+1,y,1)*XFromInput(3))+(movp(x+1,y+1,1)*XFromInput(4));
    movp_g2=(movp(x,y,2)*XFromInput(1))+(movp(x,y+1,2)*XFromInput(2))+(movp(x+1,y,2)*XFromInput(3))+(movp(x+1,y+1,2)*XFromInput(4));
    movp_b3=(movp(x,y,3)*XFromInput(1))+(movp(x,y+1,3)*XFromInput(2))+(movp(x+1,y,3)*XFromInput(3))+(movp(x+1,y+1,3)*XFromInput(4));
    

              for k=-WindowSize:WindowSize
                    for m=-WindowSize:WindowSize
                        if(x+k<=0)||(y+m<=0 || x+k>row|| y+m>col)
                            diffMat(k+WindowSize+1,m+WindowSize+1)=Inf;
                        else
                              diffPix = abs(double(movp_r1)-double(movc(x+k,y+m,1)))+abs(double(movp_g2)-double(movc(x+k,y+m,2)))+abs( double(movp_b3)-double(movc(x+k,y+m,3)));
                              diffMat(k+WindowSize+1,m+WindowSize+1)=diffPix;
                        end
                        
                       
                    end
        
              end
              %just for Upholstery
              tempMatdiffMat=diffMat(2:WindowSize*2,2:WindowSize*2);
             [ numOfMin,~]= size(ResultMat(tempMatdiffMat<thresholdRound));
             if(~NormalizeMinimumFounded||numOfMin==0)
                 numOfMin=1;
             end
              ResultMat(diffMat<thresholdRound)=ResultMat(diffMat<thresholdRound)+(1/numOfMin);
   

  
end

    if(~IncludeIdentity)
        ResultMat(WindowSize+1,WindowSize+1)=0;
    end
    
    %just for Upholstery
    tempMat=ResultMat(2:WindowSize*2,2:WindowSize*2);
    WindowSize=WindowSize-1;
    %find WindowSizeimum
    [~,ind] = max(tempMat(:));
    [m,n] = ind2sub(size(tempMat),ind); 
    if(tempMat(m,n)==   tempMat(WindowSize+1,WindowSize+1))
        m=WindowSize+1;
        n=WindowSize+1;
    end
    m=m+x-WindowSize-1;
    n= n+y-WindowSize-1;
    
end
