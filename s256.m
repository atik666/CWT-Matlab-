clear; clc;

rub = load ('D:\OneDrive - ump.edu.my\Atik_Home\Data Files\Blade Data\data_20150516_20hz\r1r2r3_20hz_16.mat');
rub = rub.Channel_003;

fault = 'rub';
hz = 20;
channel = 3;
dir = sprintf('D:/OneDrive - ump.edu.my/Atik_Home/Writing/WCNN/Blade/256/r1r2r3/%d',channel);

num_IMF = 5; NR = 100; NstdMax = 0.2; NstdMin = 0.1; fs = 5000;

k = 1;
for i = 1 : 400
y = rub(k:k+499, :);
y = neeemd(y, num_IMF, NR, NstdMax, NstdMin)';
y = reshape(y',1,[]);

[wt,f] = cwt(y,'amor',fs);
h = figure('Visible', 'off');
t = 0:numel(y)-1;
hp = pcolor(t,f,abs(wt));
hp.EdgeColor = 'none';
set(gca,'xtick',[],'ytick',[],'xticklabel',[],'yticklabel',[]);
exportgraphics(gca, sprintf('%s/FIG%d.png', dir, i));

img = imread(sprintf('%s/FIG%d.png', dir, i));
im=imresize(img,[256 256]);
imwrite(im,sprintf('%s/FIG%d.png', dir, i));
fprintf('Image saved = %d\n', i);

k = k+500;
end