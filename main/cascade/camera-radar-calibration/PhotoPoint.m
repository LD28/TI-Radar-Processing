%% find corner reflector in pixel coordinate
clear all;  close all; clc;

Pic_path='F:\ourDataset\20211018_match\LeopardCamera\match_OCULiiRadar\';
image_list = getImageList(Pic_path);

for i=1:length(image_list) 
    image_path = image_list(i).path;
    image=imread(image_path);    
    imshow(image)%��ʾ��ͼ
    title(image_path);
    set(gcf,'outerposition',get(0,'screensize'));%ʹ��ͼ��ʾ��󻯣�����ȡ��
    [data(i,4),data(i,5)] = ginput
end

save match_image_points data