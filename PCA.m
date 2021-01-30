clear;
clc;
I1 = imread('microstructure.jpg');
% imshow(I1)
%whos I1  
I2= histeq(I1); %increasing the contrast in the image for better quality
I3 = rgb2gray(I1);
%figure
%imshow(I3)
I4=im2double(I3);
dummy =0;
for j=1:800
    dummy=0;
    for i= 1:536
       dummy=dummy+I4(i,j);   
    end
    avg_f(j)=dummy/536;
end    
  I5=0 ; 
for j=1:800
   for i=1:536
     I5(i,j)=I4(i,j)-avg_f(j);   %mean centering the data 
   end    
end

[U,S,V] = svd(I5); %singular value decomposition;

r=input('enter the number of components:');

for i=1:r
    for j=1:r
      S_new(i,j)=S(i,j);    %breaking sigma as per the number of required components; 
    end    
end

for i=1:536
    for j=1:r
      U_new(i,j)=U(i,j);    %breaking U as per no. of components required;
    end    
end

for i=1:800
    for j=1:r
      V_new(i,j)=V(i,j);    %breaking V per the number of required components; 
    end    
end
Vt=transpose(V_new);
I_new=(U_new*S_new)*Vt; % forming the new matrix

for j=1:800
   for i=1:536
     I6(i,j)=I_new(i,j)+avg_f(j);  %re adding the mean matrix
   end    
end
imshow(I6);
%%%%%%%%%%%%%%%%%%%%%%%%%%%Pareto plot;
sum=0;
for i=1:536
    sum=sum+(S(i,i)^2);
end
dummy_1=0;
dummy_2=0;


for i=1:536
    dummy_1=dummy_1+(S(i,i)^2)
    dummy_2=dummy_1/sum;
    pareto(i)=dummy_2;
end

figure
plot(pareto);