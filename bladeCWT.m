clear; clc;

base = load ('D:\OneDrive - ump.edu.my\Atik_Home\Data Files\Blade Data\data_20150516_20hz\b2_20hz_16.mat');
base = base.Channel_003;

fault = 'base';
hz = 20;
dir = sprintf('D:/OneDrive - ump.edu.my/Atik_Home/Writing/WCNN/Blade/CWT/%s/%d/b2',fault,hz);

num_IMF = 5; NR = 100; NstdMax = 0.2; NstdMin = 0.1; fs = 5000;

k = 1;
for i = 1 : 400
y = base(k:k+499, :)';

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

k = k+500;
end