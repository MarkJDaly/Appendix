function [Fx, Fy, Fz] = ForceFn( Ex, Ey, Ez, Nxx, del)
%%del values need to be changed to suit the model step size
delx=del*10^-9;
dely=del*10^-9;
delz=del*10^-9;
delx2=1/delx;
%%Initialising values to 0
Tempx=0;
Tempy=0;
Tempz=0;
eps0=8.854e-12;
%%Here SqrSize is 100 becuase the summation relies on nearest neighbours
%%hence the last data point has nothing to compare to.
[r c m] = size(Ex);
SqrSize=r-1;
SqrSizez=m-1;

%%We compute the force according the MST equation which is rewritten to
%%take into account refractive index changes at boundaries. The Electric
%%field is taken as the average of two adjacent cells for x,y, and z.

for ix=1:SqrSize
    for iy=1:SqrSize
        for iz=1:SqrSizez
            Tempx=Tempx+((real(Ex(ix,iy,iz))^2+real(Ex(ix+1,iy,iz))^2)*0.5+(real(Ey(ix,iy,iz))^2+real(Ey(ix+1,iy,iz))^2)*0.5+(real(Ez(ix,iy,iz))^2+real(Ez(ix+1,iy,iz))^2)*0.5)*-0.25*eps0*delx2*(Nxx(ix,iy,iz)^2-Nxx(ix+1,iy,iz)^2)*delx*dely*delz;
        end
    end
end
Forcexpn=Tempx*10^12;
Fx=Forcexpn;
for ix=1:SqrSize
    for iy=1:SqrSize
        for iz=1:SqrSizez
            Tempy=Tempy+((real(Ex(ix,iy,iz))^2+real(Ex(ix,iy+1,iz))^2)*0.5+(real(Ey(ix,iy,iz))^2+real(Ey(ix,iy+1,iz))^2)*0.5+(real(Ez(ix,iy,iz))^2+real(Ez(ix,iy+1,iz))^2)*0.5)*-0.25*eps0*delx2*(Nxx(ix,iy,iz)^2-Nxx(ix,iy+1,iz)^2)*delx*dely*delz;
        end
    end
end
Forceypn=Tempy*10^12;
Fy=Forceypn;
for ix=1:SqrSize
    for iy=1:SqrSize
        for iz=1:SqrSizez
            Tempz=Tempz+((real(Ex(ix,iy,iz))^2+real(Ex(ix,iy,iz+1))^2)*0.5+(real(Ey(ix,iy,iz))^2+real(Ey(ix,iy,iz+1))^2)*0.5+(real(Ez(ix,iy,iz))^2+real(Ez(ix,iy,iz+1))^2)*0.5)*-0.25*eps0*delx2*(Nxx(ix,iy,iz)^2-Nxx(ix,iy,iz+1)^2)*delx*dely*delz;
        end
    end
end
Forcezpn=Tempz*10^12;
Fz=Forcezpn;

end

