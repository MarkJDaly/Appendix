%% ImportData
clear
%%Load data from Comsol output file (regular grid)
%%Start of file should be changed depending on the file name you input. Here
%%I have a file name which has the yposition as the last number. Note that
%%the number of lines in the initial textscan may need to be changed
%%depending on the file COMSOL exports. For FDTD imports, check the FDTD
%%import command.
    id=fopen('Z:\Mark Daly\Mark - OIST\FDTD\2016-1-14\device1_sensor1.amf');
    Data=textscan(id,'%s %s %s %s %s %s %s %s', 6);
    Data2=textscan(id,'%f %f %f %f %f %f %f %f');
    Ex_Ey_Ez_200nm=cat(2,Data2{1},Data2{2},Data2{3},Data2{4},Data2{5},Data2{6},Data2{7});
    fclose(id);
    sensnum=14;
    SqSz=sqrt(length(Ex_Ey_Ez_200nm(:,1)));    
    
    Fx1=zeros(1,8);
    Fy1=zeros(1,8);
    Fz1=zeros(1,8);
    
    Fx2=zeros(1,8);
    Fy2=zeros(1,8);
    Fz2=zeros(1,8);
    
    Ex=zeros(SqSz,SqSz,2*sensnum);
    Ey=zeros(SqSz,SqSz,2*sensnum);
    Ez=zeros(SqSz,SqSz,2*sensnum);
for l=2:100
    devnum=num2str(l);
for k=1:2*sensnum
    num=num2str(k);
    id=fopen(strcat('Z:\Mark Daly\Mark - OIST\FDTD\2016-1-14\device',devnum,'_sensor',num,'.amf'));
    Data=textscan(id,'%s %s %s %s %s %s %s %s', 6);
    Data2=textscan(id,'%f %f %f %f %f %f %f %f');
    Ex_Ey_Ez_200nm=cat(2,Data2{1},Data2{2},Data2{3},Data2{4},Data2{5},Data2{6},Data2{7});
   
    Ex(:,:,k)=reshape(Ex_Ey_Ez_200nm(:,3),SqSz,SqSz);
    Ey(:,:,k)=reshape(Ex_Ey_Ez_200nm(:,4),SqSz,SqSz);
    Ez(:,:,k)=reshape(Ex_Ey_Ez_200nm(:,5),SqSz,SqSz);
end

Ex1=Ex(:,:,1:sensnum);
Ex2=Ex(:,:,sensnum+1:end);
Ey1=Ey(:,:,1:sensnum);
Ey2=Ey(:,:,sensnum+1:end);
Ez1=Ez(:,:,1:sensnum);
Ez2=Ez(:,:,sensnum+1:end);

[jj,ii,kk]=meshgrid(1:26,1:26,1:14);
Nxx = (sqrt((ii-13).^2 + (jj-13).^2 + (kk-7).^2) < 5)*1.4567;
Nxx(find(Nxx<1.4))=1.33;
fclose('all');
[A B C] =ForceFn( Ex1, Ey1, Ez1, Nxx, 20);
[D E F] =ForceFn( Ex2, Ey2, Ez2, Nxx, 20);

Fx1(l)=A;
Fy1(l)=B;
Fz1(l)=C;
Fx2(l)=D;
Fy2(l)=E;
Fz2(l)=F;

end