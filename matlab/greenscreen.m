inimage = imread("test.png");
subplot(2,2,1)
imshow (inimage,[]);

[rows,columns,cc] = size(inimage);
%[r,g,b] = imsplit(inimage);
r= inimage(:,:,1);
g = inimage(:,:,2);
b = inimage(:,:,3);

rd = double(r)/255;
gd = double(g)/255;
bd = double(b)/255;

greeness = gd.*(gd-rd).*(gd-bd);
thresh = 0.3*mean(greeness(greeness>0));
greenmask = greeness > thresh;

%greenmask = (r==0)&(g==255)&(b==0);
imgmask = cast((~greenmask),'like',inimage);
object = bsxfun(@times,inimage, imgmask);
subplot(2,2,2)
imshow (object,[]);

bgdimg = imread("bgdimg.png"); 
subplot (2,2,3);
imshow (bgdimg,[]);
outputimg = bgdimg;
for col = 1:columns
    for row = 1:rows
        if imgmask(row,col)
            outputimg(row,col,:) = object(row,col,:);
        end
    end
end
subplot (2,2,4);
imshow (outputimg,[]);


