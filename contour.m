clear;clc;

fs= 12000; %Sampling frequency
normal = load ('D:\OneDrive - ump.edu.my\Atik_Home\Data Files\Bearing Data Center\Normal Baseline Data\97.mat');
inner = load('D:\OneDrive - ump.edu.my\Atik_Home\Data Files\Bearing Data Center\12K Drive End Bearing Fault Data\Inner Race\0.007\108.mat');
outer = load('D:\OneDrive - ump.edu.my\Atik_Home\Data Files\Bearing Data Center\12K Drive End Bearing Fault Data\Outer Race\0.007\133.mat');
ball = load('D:\OneDrive - ump.edu.my\Atik_Home\Data Files\Bearing Data Center\12K Drive End Bearing Fault Data\Ball\0.007\121.mat');

normal = normal.X097_DE_time; inner = inner.X108_DE_time; 
outer = outer.X133_DE_time; ball = ball.X121_DE_time; 

fault = 'normal';
hp = 3;
dir = sprintf('D:/OneDrive - ump.edu.my/Atik_Home/Writing/WCNN/6464/Contour/%s/%d',fault,hp);

k = 1;
for i = 1 : 130
    
y = normal(k:k+899, :)';

y = reshape(y, [30,30]);
figure('Visible', 'off');
contourf(y);
set(gca,'xtick',[],'ytick',[],'xticklabel',[],'yticklabel',[]);
exportgraphics(gca, sprintf('%s/FIG%d.png', dir, i));

img = imread(sprintf('%s/FIG%d.png', dir, i));
im=imresize(img,[64 64]);
imwrite(im,sprintf('%s/FIG%d.png', dir, i));
fprintf('Image saved = %d\n', i);

k = k+900;
end