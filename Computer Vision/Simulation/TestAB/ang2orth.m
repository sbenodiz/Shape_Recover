function orthm = ang2orth(ang) 

sa = sin(ang(2)); ca = cos(ang(2)); 
sb = sin(ang(1)); cb = cos(ang(1)); 
sc = sin(ang(3)); cc = cos(ang(3)); 

ra = [  ca,  sa,  0; ... 
       -sa,  ca,  0; ... 
         0,   0,  1]; 
rb = [  cb,  0,  sb; ... 
         0,  1,  0; ... 
       -sb,  0,  cb]; 
rc = [  1,   0,   0; ... 
        0,   cc, sc;... 
        0,  -sc, cc]; 
orthm = rc*rb*ra; 
