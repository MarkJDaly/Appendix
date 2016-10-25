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
    
    SqSz=sqrt(length(Ex_Ey_Ez_200nm(:,1)));    
    
    Ex=zeros(SqSz,SqSz,28);
    Ey=zeros(SqSz,SqSz,28);
    Ez=zeros(SqSz,SqSz,28);

for k=1:28
    num=num2str(k);
    id=fopen(strcat('Z:\Mark Daly\Mark - OIST\FDTD\2016-1-14\device1_sensor',num,'.amf'));
    Data=textscan(id,'%s %s %s %s %s %s %s %s', 6);
    Data2=textscan(id,'%f %f %f %f %f %f %f %f');
    Ex_Ey_Ez_200nm=cat(2,Data2{1},Data2{2},Data2{3},Data2{4},Data2{5},Data2{6},Data2{7});
   
    Ex(:,:,k)=reshape(Ex_Ey_Ez_200nm(:,3),SqSz,SqSz);
    Ey(:,:,k)=reshape(Ex_Ey_Ez_200nm(:,4),SqSz,SqSz);
    Ez(:,:,k)=reshape(Ex_Ey_Ez_200nm(:,5),SqSz,SqSz);
end

Ex1=Ex(:,:,1:14);
Ex2=Ex(:,:,15:end);
Ey1=Ey(:,:,1:14);
Ey2=Ey(:,:,15:end);
Ez1=Ez(:,:,1:14);
Ez2=Ez(:,:,15:end);
%%Sort data into blocks with the same x value (x is along the axis of the
%%fibre). 

%%SqrSize is the number of points in a cubic grid. In this case it
%%is 100*100*100. I added one to the number because of the way Matlab indexes
%%matrices.
