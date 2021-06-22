tic

imc=imread('tiantan.jpg');
img=rgb2gray(imc);
subplot(1,2,1)
imshow(img)
theta = 90;
tform = affine2d([cosd(theta) -sind(theta) 0; 
                  sind(theta) cosd(theta) 0; 
                  0 0 1]);

outputImage = imwarp(img,tform);
subplot(1,2,2)
imshow(outputImage);

%translation operation is a bit different to the universal transform function

%{
subplot(1,2,1)
imshow(img)

theta=0.5*pi;
imc=imread('tiantan.jpg');
img=rgb2gray(imc);
T=[cos(theta), sin(theta), 0;
    -sin(theta), cos(theta), 0;
          0, 0, 1];
[xMax,yMax]=size(img);
corners=[0, 0, 1;
    xMax,0,1;
    0,yMax,1;
    xMax,yMax,1];
newCorners=corners*T;
xmin=min(newCorners(:,1));
xmax=max(newCorners(:,1));
newWidth=round(xmax-xmin);
ymin=min(newCorners(:,2));
ymax=max(newCorners(:,2));
newHeight=round(ymax-ymin);
tImg=zeros(newWidth, newHeight);

for i=1:newWidth
    for j=1:newHeight
        xOffset=round(xmin);
        yOffset=round(ymin);
        temp=[i+xOffset,j+yOffset,1]/T;
        x=round(temp(1));
        y=round(temp(2));
        if x>0&&x<xMax&&y>0&&y<yMax
            %assign the nearest point value to transformed point
            tImg(i,j)=img(x,y);
        end
    end
end
subplot(1,2,2)
imshow(tImg,[]);
%}
toc
title({'Total execution time of';
'self function is';num2str(toc);'seconds'});
