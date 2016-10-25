%%Initialize data, this may need to be altered depending on how your video
%%is imported
[len1,len2,len3]=size(A(1,1).cdata);
len=len1;
plots=zeros(1,len);
maxframes=length(A);
maxpos=zeros(1,maxframes);
plots=zeros(1,len,maxframes);
GaussResolution=.25; %% This resolution needs to be determined later. If you have a lot of pixels you can easily have super-resolution in the tracking of the particle center. 0.5 is a conservative estimate
%% Each iteration of the loop 'tracks' the particle position by getting the mean of each column and finding the brightest spot.
for k=1:maxframes  
    %% Average of columns
    temp=mean(rgb2gray(A(1,k).cdata)'); 
    %% position vector for use in polyfit
    pos=[1:len]; 
    %% The illuminatin may have an associated slope which needs to be subtracted to ensure the correct maxima is selected
    temp2=polyfit(pos,temp,1); 
    subtractline=polyval(temp2,[1:len]);  
    %% slope removed from data
    temp=temp-subtractline;     
    %% add this plot to a 3D matrix in case you want to see it later.
    plots(:,:,k)=temp; 
    [xData, yData] = prepareCurveData( pos, temp );    
    %% gaussian fit to data
    soln=fit(xData,yData,'gauss1'); 
    soln2=feval(soln,[1:GaussResolution:len]);
    %% find maximum of Gaussian
    [Max,Ind]=max(soln2);
    maxpos(1,k)=Ind;
end

