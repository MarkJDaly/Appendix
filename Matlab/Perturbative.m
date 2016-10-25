%%Perturbative calculation - dipole approximation
%%del values need to be changed to suit the model step size
delx=4*10^-9;
dely=4*10^-9;
delz=4*10^-9;
%%Initialising values to 0
Tempx=0;
Tempy=0;
Tempz=0;
eps0=8.854e-12;
nm=1.33;
np=1.45591;
c=3*10^8;
r=100*10^-9;
lambda=980*10^-9;
G_const=2*nm^2*r^3*eps0*((np^2-nm^2)/(np^2+2*nm^2));
S_const=128/3*pi^5*r^6/lambda^4*((np^2-nm^2)/(np^2+2*nm^2))*nm;
clearvars Fgradxpn Fgradypn Fgradzpn
if exist('Fgradxpn')
else Fgradxpn=0;
end
if exist('Fgradypn')
else Fgradypn=0;
end
if exist('Fgradzpn')
else Fgradzpn=0;
end
for i=1:12
    
    posx=51;
    posy=38;
    posz=51;
    Tempxpn=G_const*10^12*(Enorm(posx+1,posy+2*i,posz)-Enorm(posx,posy+2*i,posz))/delx;
    Fgradxpn=cat(2,Fgradxpn,Tempxpn);
   
    
    Tempypn=G_const*10^12*(Enorm(posx,posy+1+2*i,posz)-Enorm(posx,posy+2*i,posz))/delx;
    Fgradypn=cat(2,Fgradypn,Tempypn);
    
    
    Tempzpn=G_const*10^12*(Enorm(posx,posy+2*i,posz+1)-Enorm(posx,posy+2*i,posz))/delx;
    Fgradzpn=cat(2,Fgradzpn,Tempzpn);
end
 Fgradxpn(1)=[];
 Fgradypn(1)=[];
 Fgradzpn(1)=[];