function [ I ] = crop_cpu_2( im )
img = rgb2gray(im);
imc = edge(img,'canny');
imf = imfill(imc,'holes');
imc = imclearborder(imf,4);
imc = imclearborder(imc,8);
sed = strel('disk',10);
%sedi = strel ('diamond',5);
ime = imerode(imc,sed);
%ime = imerode(ime,sedi);
I = img;
for i = 1:size(ime,1)
    for j = 1:size(ime,2)
        if(ime(i,j)==1)
            I(i,j)=img(i,j);
        else
            I(i,j)=0;
        end
    end
end
end

