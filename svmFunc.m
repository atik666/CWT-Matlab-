clear; clc;

data = 't1t2t3';
base = load(sprintf('D:/OneDrive - ump.edu.my/Atik_Home/Data Files/Blade Data/data_20150516_20hz/%s_20hz_16.mat',data));
base = base.Channel_003;

num_IMF = 5; NR = 100; NstdMax = 0.2; NstdMin = 0.1; fs = 5000;

imf = {};

k = 190501;
for i = 382 : 400
y = base(k:k+499, :);
y = neeemd(y, num_IMF, NR, NstdMax, NstdMin);
y1 = EnergyFun(y);
y2 = kurtosis(y);
feat = horzcat(y1, y2);
imf{i,1} = feat;
fprintf('processed: %d\n', i);
k = k+500;
end

imf = cell2mat(imf);
csvwrite(sprintf('D:/OneDrive - ump.edu.my/Atik_Home/Writing/WCNN/Blade/SVM/EEMD/%s.csv', data),imf);