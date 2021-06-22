%translation operation is a bit different to the universal transform function
img=imgTranslate(50,45);
figure(1)
imshow(img,[]);
print('trans50-45','-dpng');
function imgTranslation=imgTranslate(tx,ty)
       imc=imread('im1.png');
       img=rgb2gray(imc);
       [xMax,yMax]=size(img);
       imgTranslation=zeros(xMax+tx,yMax+ty);
       for i=1:xMax
           for j=1:yMax
               imgTranslation(i+tx,j+ty)=img(i,j);
           end
       end
end