clc; clear;
fs= 12000; %Sampling frequency

type = 'FE'; load = 3; fault = 'normal';
source = 'D:/OneDrive - ump.edu.my/Atik_Home/Writing/WCNN/Code/dataLMD';
dir = sprintf('D:/OneDrive - ump.edu.my/Atik_Home/Writing/WCNN/Bearing/NEELMD/%s/%s/%d',fault,type,load);

data = xlsread('D:/OneDrive - ump.edu.my/Atik_Home/Writing/WCNN/Code/dataLMD/100.xlsx',type);

for i = 1 : 200
    y = data(i, 1:end)';
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
end