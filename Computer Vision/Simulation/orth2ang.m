function ang = orth2ang(orthm) 
ang(1) = asin(orthm(1,3)); %Wei du 
ang(2) = angle( orthm(1,1:2)*[1 ;i] ); %Jing Du 
yz = orthm* ... 
    [orthm(1,:)',... 
     [-sin(ang(2)); cos(ang(2)); 0],... 
     [-sin(ang(1))*cos(ang(2)); -sin(ang(1)*sin(ang(2))); 
cos(ang(1))] ]; 

ang(3) = angle(yz(2,2:3)* [1; i]); % Xuan Du 
end