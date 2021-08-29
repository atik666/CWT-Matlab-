clear;clc;
fs= 12000; %Sampling frequency

type = 'Norm';
severity = "0.021";
data = load(sprintf('D:/OneDrive - ump.edu.my/Atik_Home/Data Files/Bearing Data Center/Normal Baseline Data/97.mat'));

data = data.X097_DE_time;

fault = type+severity;
dir = sprintf('D:/OneDrive - ump.edu.my/Atik_Home/Writing/WCNN/Bearing 2.0/NEEEMD/Norm');

num_IMF = 5; NR = 100; NstdMax = 0.2; NstdMin = 0.1;

k = 1;
for i = 1 : 200
y = data(k:k+599, :);
y = neeemd(y, num_IMF, NR, NstdMax, NstdMin);
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