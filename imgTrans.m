%function newImg=transImg(theta,tx,ty,cx,cy,sv,sh, operation)
%figure(1)

subplot(4,3,1)
img1=transImg(0,0,0,0,0,'rotate');
imshow(img1,[])
title("original image")

%figure(2)
subplot(4,3,2)
img2=transImg(0.25*pi,0,0,0,0,'rotate');
imshow(img2,[])
title("rotated 45 degree image")

%figure(3)
subplot(4,3,3)
img3=transImg(0.5*pi,0,0,0,0,'rotate');
imshow(img3,[])
title("rotated 90 degree image")

%figure(4)
subplot(4,3,4)
img4=transImg(-0.1389*pi, 0,0,0,0,'rotate');
imshow(img4,[])
title("rotated -25 degree image")

%figure(6)
subplot(4,3,6)
img6=transImg(0, 0.25,0.75,0,0,'scale');
imshow(img6,[])
title("scale image with cx=0.5, cy=1.5")

%figure(7)
subplot(4,3,7)
img7=transImg(0, 0,0,0.2,0,'shearV');
imshow(img7,[])
title("vertically sheared image with sv=0.2")

%figure(8)
subplot(4,3,8)
img8=transImg(0, 0,0,0,0.3,'shearH');
imshow(img8,[])
title("Horizontally sheared image with sv=0.3")

function tImg=transImg(theta,cx,cy,sv,sh, operation)

transChoice=operation;
switch transChoice
    case 'rotate'
        T=[cos(theta), sin(theta), 0;
          -sin(theta), cos(theta), 0;
          0, 0, 1];
      
    case 'scale'
        T=[cx, 0, 0;
           0, cy, 0;
           0, 0, 1];
       
    case 'shearV'
        T=[1, sv, 0;
           0, 1, 0;
           0, 0, 1];
    case 'shearH'
        T=[1, 0, 0;
           sh, 1, 0;
           0, 0, 1];
end


imc=imread('im1.png');
img=rgb2gray(imc);

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
end




