imc=imread('im1.png');
img=rgb2gray(imc);
th=0.2*pi;
figure(1)
imshow(img,[])
figure(2)
imshow(transImg,[])
T=[cos(th), sin(th), 0;
    -sin(th), cos(th), 0;
       0,       0,     1];
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
transImg=zeros(newWidth, newHeight);

for i=1:newWidth
    for j=1:newHeight
        xOffset=round(xmin);
        yOffset=round(ymin);
        temp=[i+xOffset,j+yOffset,1]/T;
        x=round(temp(1));
        y=round(temp(2));
        if x>0&&x<xMax&&y>0&&y<yMax
            %assign the nearest point value to transformed point
            transImg(i,j)=img(x,y);
        end
    end
end