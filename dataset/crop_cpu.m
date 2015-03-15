function [I] = crop_cpu(im)
im=rgb2gray(im);
imedge=edge(im,'sobel');
int_horz=zeros(size(im,1),1);
int_vert=zeros(size(im,2),1);

windowSize=7;
b = (1/windowSize)*ones(1,windowSize);
a = 1;

for i=1:size(im,1)
    for j=2:(size(im,2)-1)
        if imedge(i,j)~=imedge(i,j-1) && imedge(i,j)~=imedge(i,j+1)
            int_horz(i)=int_horz(i)+1;
        end
    end
end
int_horz=filter(b,a,int_horz);
[max_horz,idx_h1]=max(int_horz);
%[min_horz,idx_h2]=min(int_horz);
thresh_horz=int_horz>(max_horz*0.25);

for i=2:(size(im,1)-1)
    for j=1:size(im,2)
        if imedge(i,j)~=imedge(i-1,j) && imedge(i,j)~=imedge(i+1,j)
            int_vert(j)=int_vert(j)+1;
        end
    end
end
int_vert=filter(b,a,int_vert);
[max_vert,idx_v1]=max(int_vert);
%[min_vert,idx_v2]=min(int_vert);
thresh_vert=int_vert>(max_vert*0.25);

a1=1;a2=size(im,1);b1=1;b2=size(im,2);
count=0;
for i=idx_h1:-1:1
    if thresh_horz(i)~=1
        count=count+1;
        if count>=10
            a1=i;
            break;
        end
    end
end
count=0;
for i=idx_h1:1:size(im,1)
    if thresh_horz(i)~=1
        count=count+1;
        if count>=10
            a2=i;
            break;
        end
    end
end
count=0;
for i=idx_v1:-1:1
    if thresh_vert(i)~=1
        count=count+1;
        if count>=10
            b1=i;
            break;
        end
    end
end
count=0;
for i=idx_v1:1:size(im,2)
    if thresh_vert(i)~=1
        count=count+1;
        if count>=10
            b2=i;
            break;
        end
    end
end

I = imcrop(im,[b1 a1 b2-b1 a2-a1]);
end
