figure(6)
img7=transImg(0.2778*pi, 25,30,0,0,0,0,'rotAndtrans');
imshow(img7,[])
title("translate image with tx=50, ty=50")

function tImg=transImg(theta,tx,ty,cx,cy,sv,sh, operation)

transChoice=operation;
switch transChoice
    case 'rotate'
        T=[cos(theta), sin(theta), 0;
          -sin(theta), cos(theta), 0;
          0, 0, 1];
    case 'translate'
        T=[1, 0, 0;
           0, 1, 0;
           tx, ty, 1];
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
    case 'rotAndtrans'
         T=[cos(theta), sin(theta), 0;
          -sin(theta), cos(theta), 0;
          200, 100, 1];
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

for i=1:newWidth+25
    for j=1:newHeight+30
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


