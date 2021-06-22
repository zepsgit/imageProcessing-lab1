imc = imread('im2.png');% Read the image
img = rgb2gray(imc); % Convert to grayscale

H=size(img,1); % Read the height of the image
W=size(img,2); % Read the width of the image
Hist_arr=zeros(1,256); % Array for holding the (original) histogram
Hist_eq_arr=zeros(1,256); % Array for holding the (equalized)
CDF_array=zeros(1,length(Hist_arr)); % array to hold

hist_eq_img=uint8(zeros(H,W)); % A 2D array for keeping

for i=1:H
for j=1:W
Hist_arr(1,img(i,j)+1)=Hist_arr (1,img(i,j)+1)+1 ;
end
end

Hist_arr_pdf=Hist_arr/(H*W); % PDF
dummy1=0; % A dummy variable to hold the summation results
for k=1:length(Hist_arr) % Generating the CDF from PDF
dummy1=dummy1+Hist_arr_pdf(k);
CDF_array(k)= dummy1;
end
for l=1:H % Histogram equalization
for m=1:W
hist_eq_img(l,m)= round(CDF_array(img(l,m)+1)*...
(length(Hist_arr_pdf)-1)); % scale to 255 and round to
Hist_eq_arr(1, hist_eq_img(l,m)+1)=...
Hist_eq_arr(1,hist_eq_img(l,m)+1)+1 ; % Its histogram
end
end

subplot(3,2,1)
bar(Hist_arr);
title("original histogram")

subplot(3,2,2)
bar(Hist_eq_arr);
title("equalized histogram")

subplot(3,2,3)
bar(CDF_array);
title("CDF histogram")
subplot(3,2,5)
imshow(img);
title("original image");

subplot(3,2,6)
imshow(hist_eq_img,[])
title("equalized image");
print('eq','-dpng');