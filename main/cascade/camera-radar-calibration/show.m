%% ���ֱ��ͼ
clear all; close all; clc;

load allpoints
load('Hx_combine.mat', 'Hx');
H=Hx;

for i=1:length(data)
    data1=data(i,1:3)';
    I=size(data1,2);
    data1=[data1;ones(1,I)];
    xc=H*data1*(diag(1./([0,0,1]*H*data1)));
    xc=floor(xc);
    xc(3,:)=[];
    error(i)=norm(xc - data(i,4:5)');
end
sum(error)
bar(error);
grid on;
xlabel('groupId');
ylabel('(u, v) L2 error');

%% ����������
clear all; close all; clc;

SAVE_ON = 0;
WAITKEY_ON = 1-SAVE_ON;

load allpoints
load('Hx_combine.mat', 'Hx');
H=Hx;

Pic_path='F:\ourDataset\20211018_match\LeopardCamera\match_OCULiiRadar\';
image_list = getImageList(Pic_path);
save_results_folder = '20211018LeopardCamera_OCULiiRadar/results';

figure();
for i=1:length(image_list) 
    data1=data(i,1:3)';
    I=size(data1,2);
    data1=[data1;ones(1,I)];
    xc=H*data1*(diag(1./([0,0,1]*H*data1)));
    xc=floor(xc);
    xc(3,:)=[];
    error(i)=norm(xc - data(i,4:5)');
    
    image = imread(image_list(i).path);
    imshow(image);
    hold on;
    scatter(data(i,4), data(i,5), 'filled', 'g');
    scatter(xc(1), xc(2), 'filled', 'r');    
    hold off;
    title([image_list(i).name, '    Error = ',num2str(error(i)), '    GT = (', num2str(data(i,4)), ',', num2str(data(i,4)), ')    Transfer = (', num2str(xc(1)), ',', num2str(xc(2)), ')']);
    
    if SAVE_ON
        saveas(gcf, [save_results_folder, '/match', num2str(i), '.png']);
    end
    
    if WAITKEY_ON == 1
        %������һ֡         
        key = waitforbuttonpress;
        while(key==0)
            key = waitforbuttonpress;
        end
    end
    
end


%% ���������
clear all; close all; clc;

SAVE_ON = 1;
WAITKEY_ON = 1-SAVE_ON;

load allpoints
load('Hx_combine.mat', 'Hx');
H=Hx;

Pic_path='F:\ourDataset\20211018_match\LeopardCamera\match_OCULiiRadar\';
save_results_folder = '20211018LeopardCamera_OCULiiRadar/results';
image_list = getImageList(Pic_path);
load("D:\matlab_workspace\Camera-instrinc-calibration\LeopardCamera1.mat");


figure();
for i=1:length(image_list) 
    data1=data(i,1:3)';
    I=size(data1,2);
    data1=[data1;ones(1,I)];
    xc=H*data1*(diag(1./([0,0,1]*H*data1)));
    xc=floor(xc);
    xc(3,:)=[];
    error(i)=norm(xc - data(i,4:5)');
    
    image = imread(image_list(i).path);
    img_undistort = undistortImage(image, cameraParams); 
    imshow(img_undistort);
    hold on;
    scatter(data(i,4), data(i,5), 'filled', 'g');
    scatter(xc(1), xc(2), 'filled', 'r');    
    hold off;
    title([image_list(i).name, '    Error = ',num2str(error(i)), '    GT = (', num2str(data(i,4)), ',', num2str(data(i,4)), ')    Transfer = (', num2str(xc(1)), ',', num2str(xc(2)), ')']);
    
    if SAVE_ON
        saveas(gcf, [save_results_folder, '/match', num2str(i), '.png']);
    end
    
    if WAITKEY_ON == 1
        %������һ֡         
        key = waitforbuttonpress;
        while(key==0)
            key = waitforbuttonpress;
        end
    end
    
end



