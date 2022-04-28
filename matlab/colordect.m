inimage = imread("rgbt.png");
subplot(2,3,2)
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
threshg = 0.3*mean(greeness(greeness>0));
greenmask = greeness > threshg;

redness = rd.*(rd-gd).*(rd-bd);
threshr = 0.3*mean(redness(redness>0));
redmask = redness > threshr;

blueness = bd.*(bd-gd).*(bd-rd);
threshb = 0.3*mean(blueness(blueness>0));
bluemask = blueness > threshb;

imgmaskg = cast((~greenmask),'like',inimage);
objectg = bsxfun(@times,inimage, imgmaskg);
objectg = objectg./2;


imgmaskr = cast((~redmask),'like',inimage);
objectr = bsxfun(@times,inimage, imgmaskr);
objectr = objectr./2;


imgmaskb = cast((~bluemask),'like',inimage);
objectb = bsxfun(@times,inimage, imgmaskb);
objectb = objectb./2;




outputimgr = inimage.*1.3;
for col = 1:columns
    for row = 1:rows
        if imgmaskr(row,col)
            outputimgr(row,col,:) = objectr(row,col,:);
        end
    end
end
subplot (2,3,4);
imshow (outputimgr,[]);

outputimgg = inimage.*1.3;
for col = 1:columns
    for row = 1:rows
        if imgmaskg(row,col)
            outputimgg(row,col,:) = objectg(row,col,:);
        end
    end
end
subplot (2,3,5);
imshow (outputimgg,[]);

outputimgb = inimage.*1.3;
for col = 1:columns
    for row = 1:rows
        if imgmaskb(row,col)
            outputimgb(row,col,:) = objectb(row,col,:);
        end
    end
end
subplot (2,3,6);
imshow (outputimgb,[]);

