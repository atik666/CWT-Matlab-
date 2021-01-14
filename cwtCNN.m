clear;clc;

fs= 12000; %Sampling frequency
load 'D:\OneDrive Updated\OneDrive - ump.edu.my\Atik_Home\Data Files\Codes\base.mat';
load('D:\OneDrive Updated\OneDrive - ump.edu.my\Atik_Home\Data Files\Codes\IR007_0.mat')
load('D:\OneDrive Updated\OneDrive - ump.edu.my\Atik_Home\Data Files\Codes\OR007@6_0.mat');
load('D:\OneDrive Updated\OneDrive - ump.edu.my\Atik_Home\Data Files\Codes\B007_0.mat');

k = 1;
level = 6;
wave = 'sym6';

y = X097_DE_time(k:k+600,:);
cwt(y, fs);
set(gca, 'Visible', 'off')
cb = colorbar('Location','eastoutside');
cb.Position = cb.Position + [1 0 0 0];

    wpt = wpdec(y,level,wave);
    h = figure;
    [S,T,F] = wpspectrum(wpt,fs,'plot');
    set(gca, 'Visible', 'off')
    set(groot,'defaultFigureVisible','off') 
    cb = colorbar('Location','eastoutside');
    cb.Position = cb.Position + [10 0 0 0];

ss = sum(Signal,2)/2;
sound(ss,44100);

Signal = audioread('C:\Users\Atik\Documents\Sound recordings\Recording.m4a');

y = X097_DE_time(1:900,:);
y = reshape(y, [30 30]);
contourf(y)
% for L = 1:200
%     y = X118_DE_time(k:k+600,:);
%     k = k+600;
%     wpt = wpdec(y,level,wave);
%     h = figure;
%     [S,T,F] = wpspectrum(wpt,fs,'plot');
%     set(gca, 'Visible', 'off')
%     set(groot,'defaultFigureVisible','off') 
%     saveas(h,sprintf('D:/OneDrive Updated/OneDrive - ump.edu.my/Atik_Home/Writing/WCNN/ballFig/FIG%d.png',L));
% end