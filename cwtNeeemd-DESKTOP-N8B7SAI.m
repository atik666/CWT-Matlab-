clear;clc;

fs= 12000; %Sampling frequency
normal = load ('D:\OneDrive - ump.edu.my\Atik_Home\Data Files\Bearing Data Center\Normal Baseline Data\100.mat');
inner = load('D:\OneDrive - ump.edu.my\Atik_Home\Data Files\Bearing Data Center\12K Drive End Bearing Fault Data\Inner Race\0.007\108.mat');
outer = load('D:\OneDrive - ump.edu.my\Atik_Home\Data Files\Bearing Data Center\12K Drive End Bearing Fault Data\Outer Race\0.007\133.mat');
ball = load('D:\OneDrive - ump.edu.my\Atik_Home\Data Files\Bearing Data Center\12K Drive End Bearing Fault Data\Ball\0.007\121.mat');

normal = normal.X100_DE_time; inner = inner.X108_DE_time; 
outer = outer.X133_DE_time; ball = ball.X121_DE_time; 

fault = 'ball';
hp = 3;
dir = sprintf('D:/OneDrive - ump.edu.my/Atik_Home/Writing/WCNN/Bearing/CEEMD/%s/%d',fault,hp);

num_IMF = 5; NR = 100; NstdMax = 0.2; NstdMin = 0.1;

k = 1;
for i = 1 : 50
y = ball(k:k+599, :);
y = ceemd(y', num_IMF, NR, NstdMax, NstdMin);
y = reshape(y,1,[]);

[wt,f] = cwt(y,'amor',fs);
h = figure('Visible', 'off');
t = 0:numel(y)-1;
hp = pcolor(t,f,abs(wt));
hp.EdgeColor = 'none';
set(gca,'xtick',[],'ytick',[],'xticklabel',[],'yticklabel',[]);
exportgraphics(gca, sprintf('%s/FIG%d.png', dir, i));

img = imread(sprintf('%s/FIG%d.png', dir, i));
im=imresize(img,[64 64]);
imwrite(im,sprintf('%s/FIG%d.png', dir, i));
fprintf('Image saved = %d\n', i);

k = k+600;
end