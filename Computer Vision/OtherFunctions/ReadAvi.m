function video=ReadAvi(FileName,MaxFrame)

    
obj=VideoReader(FileName);
a=read(obj);
frames=get(obj,'numberOfFrames');
if(nargin>1)
    if(frames>MaxFrame+1)
        frames=MaxFrame+1;
    end
end
for k = 1 : frames-1
I(k).cdata = a(:,:,:,k);
I(k).colormap = [];

end;
video=I;


