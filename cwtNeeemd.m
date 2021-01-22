clear;clc;

fs= 12000; %Sampling frequency
normal = load ('D:\OneDrive - ump.edu.my\Atik_Home\Data Files\Bearing Data Center\Normal Baseline Data\99.mat');
inner = load('D:\OneDrive - ump.edu.my\Atik_Home\Data Files\Bearing Data Center\12K Drive End Bearing Fault Data\Inner Race\0.021\209.mat');
outer = load('D:\OneDrive - ump.edu.my\Atik_Home\Data Files\Bearing Data Center\12K Drive End Bearing Fault Data\Outer Race\0.021\234.mat');
ball = load('D:\OneDrive - ump.edu.my\Atik_Home\Data Files\Bearing Data Center\12K Drive End Bearing Fault Data\Ball\0.021\222.mat');

normal = normal.X099_DE_time; inner = inner.X209_DE_time; 
outer = outer.X234_DE_time; ball = ball.X222_DE_time; 

fault = 'ball';
hp = 0;
dir = sprintf('D:/OneDrive - ump.edu.my/Atik_Home/Writing/WCNN/cwtNeeemd/Severity/0.021/%s/%d',fault,hp);

num_IMF = 1; NR = 100; NstdMax = 0.2; NstdMin = 0.1;

k = 1;
for i = 1 : 200
    
y = ball(k:k+599, :);
y = neeemd(y, num_IMF, NR, NstdMax, NstdMin)';

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