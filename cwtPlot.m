clear;clc;

fs= 12000; %Sampling frequency
normal = load ('D:\OneDrive - ump.edu.my\Atik_Home\Data Files\Bearing Data Center\Normal Baseline Data\99.mat');
inner = load('D:\OneDrive - ump.edu.my\Atik_Home\Data Files\Bearing Data Center\12K Drive End Bearing Fault Data\Inner Race\0.007\107.mat');
outer = load('D:\OneDrive - ump.edu.my\Atik_Home\Data Files\Bearing Data Center\12K Drive End Bearing Fault Data\Outer Race\0.007\132.mat');
ball = load('D:\OneDrive - ump.edu.my\Atik_Home\Data Files\Bearing Data Center\12K Drive End Bearing Fault Data\Ball\0.007\120.mat');

normal = normal.X099_DE_time; inner = inner.X107_DE_time; 
outer = outer.X132_DE_time; ball = ball.X120_DE_time; 

fault = 'inner';
hp = 2;
dir = sprintf('D:/OneDrive - ump.edu.my/Atik_Home/Writing/WCNN/6464/%s/%d',fault,hp);

k = 1;
for i = 1 : 200
    
y = inner(k:k+599, :)';

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