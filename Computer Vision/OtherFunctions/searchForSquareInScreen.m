function  searchForSquareInScreen(movi,MapAllPixel,problemPoints,choosenX,choosenY,upperFirstPoint,UpperSecondPoint,lowerFirstPoint,lowerSecondPoint)
numMotionPixel=size(MapAllPixel,1);

minScore=Inf;
minScorePointUpeer=[0,0];
minScorePointLower=[0,0];
for i=1:numMotionPixel
    currx=MapAllPixel(i,1);
    curry=MapAllPixel(i,2);
    if  currx>choosenX(1) &&  currx<choosenX(2)  &&  curry>choosenY(1)  &&  curry<choosenY(2) 
        %screen
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
                
                upperFirstPointMirror=upperFirstPoint;
                UpperSecondPointMirror=UpperSecondPoint;
                lowerFirstPointMirror=lowerFirstPoint;
                lowerSecondPointMirror=lowerSecondPoint;
                
                upperFirstPointScreen=[currx,curry];
                UpperSecondPointScreen=[MapAllPixel(i,3),MapAllPixel(i,4)];
                lowerFirstPointScreen=[MapAllPixel(numberNextRow,1),MapAllPixel(numberNextRow,2)];
                lowerSecondPointScreen=[MapAllPixel(numberNextRow,3),MapAllPixel(numberNextRow,4)];
                UpperPointMirror=[upperFirstPointMirror,UpperSecondPointMirror];
                LowerPointMirror=[lowerFirstPointMirror,lowerSecondPointMirror];
                UpperPointScreen=[upperFirstPointScreen,UpperSecondPointScreen];
                LowerPointScreen=[lowerFirstPointScreen,lowerSecondPointScreen];
               
            
                score=getScoreForSqure(movi,MapAllPixel,problemPoints,UpperPointMirror,LowerPointMirror,UpperPointScreen,LowerPointScreen);
                if score<minScore
                    minScore=score;
                    minScorePointUpeer=UpperPointScreen;
                    minScorePointLower=LowerPointScreen;
                end
            
            end
        end
        
    elseif  currx>choosenX(3) &&  currx<choosenX(4)  &&  curry>choosenY(3)  &&  curry<choosenY(4) 
        %mirror
       
    end    
    
end
          
       
%             
            figure,imshow(movi(1).cdata)
            hold on
            plot(UpperPointMirror(1,2),UpperPointMirror(1,1),'^','markerfacecolor',[0 0 1]);
            plot(UpperPointMirror(1,4),UpperPointMirror(1,3),'^','markerfacecolor',[0 0 1]);
            plot(LowerPointMirror(1,2),LowerPointMirror(1,1),'^','markerfacecolor',[0 0 1]);
            plot(LowerPointMirror(1,4),LowerPointMirror(1,3),'^','markerfacecolor',[0 0 1]);
            plot(minScorePointUpeer(1,2),minScorePointUpeer(1,1),'^','markerfacecolor',[0 0 1]);
            plot(minScorePointUpeer(1,4),minScorePointUpeer(1,3),'^','markerfacecolor',[0 0 1]);
            plot(minScorePointLower(1,2),minScorePointLower(1,1),'^','markerfacecolor',[0 0 1]);
            plot(minScorePointLower(1,4),minScorePointLower(1,3),'^','markerfacecolor',[0 0 1]);
   



end




