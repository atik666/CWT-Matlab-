clc;clear;close all;

load('D:\OneDrive - ump.edu.my\Atik_Home\Data Files\Bearing Data Center\Normal Baseline Data\100.mat');

L = 1;
for j = 1 : 300
    y{j,1} = X100_DE_time(L:400+L-1,:);
    y{j,1} = normalize(y{j,1}, 'range', [-1 1]);
    data{j,1} = reshape(y{j,1}, [20 20]);
    L = L + 400;
    h = figure('Visible', 'off');
    contourf(data{j,1})
    set(gca,'xtick',[],'ytick',[])
    set(gca,'xticklabel',[],'yticklabel',[])
    saveas(h,sprintf('D:/OneDrive - ump.edu.my/Atik_Home/Writing/WCNN/conImages/normalFig/3/FIG%d.png',j));
end


