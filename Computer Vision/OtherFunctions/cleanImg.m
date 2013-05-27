function I=cleanImg(x)

[M,N] = size(x);
y = zeros(size(x));

r = 1;     % Adjust for desired window size

for n = 1+r:N-r
    for m = 1+r:M-r
        % Extract a window of size (2r+1)x(2r+1) around (m,n)
         w = x(m+(-r:r),n+(-r:r));
         [s,~]=size(find(w));
        if (s >4)
            result=255;
        else
            result=0;
        end
        % ... write the filter here ...

        y(m,n) = result;
    end
end

I=y;

end