clear;clc;

fs= 12000; %Sampling frequency
normal = load ('D:\OneDrive - ump.edu.my\Atik_Home\Data Files\Bearing Data Center\Normal Baseline Data\97.mat');
inner = load('D:\OneDrive - ump.edu.my\Atik_Home\Data Files\Bearing Data Center\12K Drive End Bearing Fault Data\Inner\0.007\108.mat');
outer = load('D:\OneDrive - ump.edu.my\Atik_Home\Data Files\Bearing Data Center\12K Drive End Bearing Fault Data\Outer Race\0.007\133.mat');
ball = load('D:\OneDrive - ump.edu.my\Atik_Home\Data Files\Bearing Data Center\12K Drive End Bearing Fault Data\Ball\0.007\121.mat');

normal = normal.X097_DE_time; inner = inner.X108_DE_time; 
outer = outer.X133_DE_time; ball = ball.X121_DE_time; 

fault = 'inner';
hp = 3;
dir = sprintf('D:/OneDrive - ump.edu.my/Atik_Home/Writing/WCNN/Bearing/NEEEMD/Load/%s/DE/%d',fault,hp);

num_IMF = 5; NR = 100; NstdMax = 0.2; NstdMin = 0.1;

k = 1;
for i = 1 : 200   
y = normal(k:k+599, :);
y = neeemd(y, num_IMF, NR, NstdMax, NstdMin)';

a = 0;
for j = 1:num_IMF
[wt,f] = cwt(y(j,:),'amor',fs);
a = a+wt;
end

h = figure('Visible', 'off');
SC = wscalogram('image',a);
hp = pcolor(SC);
hp.EdgeColor = 'none';
set(gca,'xtick',[],'ytick',[],'xticklabel',[],'yticklabel',[]);
exportgraphics(gca, sprintf('%s/FIG%d.png', dir, i));

img = imread(sprintf('%s/FIG%d.png', dir, i));
im=imresize(img,[64 64]);
imwrite(im,sprintf('%s/FIG%d.png', dir, i));
fprintf('Image saved = %d\n', i);

k = k+600;
end