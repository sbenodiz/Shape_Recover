mirrormovie = (ReadAvi('mirrormovie.avi'));
screenmovie = (ReadAvi('screenmovie.avi'));


imwrite( screenmovie(80).cdata,'screenmovie.png','png');

