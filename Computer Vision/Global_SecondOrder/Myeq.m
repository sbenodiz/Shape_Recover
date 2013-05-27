function c = Myeq(a,b)
if iscell(b) && ~iscell(a)
    c = eq(b,a);
else
    c = cell(size(a));
    for n = 1:numel(c)
        c{n} = isequal(a(n),b);
    end
end