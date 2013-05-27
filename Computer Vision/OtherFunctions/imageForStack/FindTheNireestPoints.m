function Points=FindTheNireestPoints(p1,distanseMatrix,MapCorrespondencePixel,k,includI)
if includI
    addForIdenty=1;
else
    addForIdenty=0;
end
[a ~]=find(MapCorrespondencePixel(:,3)==p1(1));
[c ~]=find(MapCorrespondencePixel(:,4)==p1(2));
 curLineNumber=intersect(a,c);
 
  row=distanseMatrix(curLineNumber,:);
  rowSorted=sort(row(1,:));

  for i=1:k
 
   indexInRow= row(1,:)==rowSorted(i+addForIdenty);
    
   Points(i:i-1+ size(find(indexInRow==1),2),:)=MapCorrespondencePixel(indexInRow,3:4);

  end

end