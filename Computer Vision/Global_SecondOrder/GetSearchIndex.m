function [ index ] = GetSearchIndex( SerachRes )


for i=1:size(SerachRes,2)
   if  isequal(SerachRes(i),{1})
        index=i;
        return
   end

end

index=0;


end

