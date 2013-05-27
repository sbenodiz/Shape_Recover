function im=derivative(img)

u=img;
U=double(img); % U is now of class double
[M, N, P]=size(u);
h=1.0;
dx_plus=zeros([M, N, P]);
dx_plus2=zeros([M, N, P]);

for i=1:M-1
    for j=1:N
        dx_plus(i, j, :)=(u(i+h, j, :)-u(i, j, :))/h;
        dx_plus2(i, j, :)=(U(i+h, j, :)-U(i, j, :))/h;
    end
end
difference=abs(dx_plus2-dx_plus);
im=difference;


end