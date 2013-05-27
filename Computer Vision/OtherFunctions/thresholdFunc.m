function m=thresholdFunc(mat,threshold,MaxValue)
mat(mat<threshold)=0;

mat(mat>=threshold)=MaxValue;
m=mat;
end