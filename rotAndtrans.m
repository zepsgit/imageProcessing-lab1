img=rotNtrans(0.2778*pi,50,100);
figure(1)
imshow(img,[]);
print('rotAndtrans','-dpng')

function tImg=rotNtrans(theta,tx,ty)
imc=imread('im1.png');
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
tImg=zeros(newWidth+tx, newHeight+ty);

for i=1:newWidth
    for j=1:newHeight
        xOffset=round(xmin);
        yOffset=round(ymin);
        temp=[i+xOffset,j+yOffset,1]/T;
        x=round(temp(1));
        y=round(temp(2));
        if x>0&&x<xMax&&y>0&&y<yMax
            %assign the nearest point value to transformed point
            tImg(i+tx,j+ty)=img(x,y);
        end
    end
end
end