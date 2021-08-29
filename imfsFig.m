clear;clc;

fs= 12000; %Sampling frequency

file = '97';
data = load(sprintf('D:/OneDrive - ump.edu.my/Atik_Home/Data Files/Bearing Data Center/Normal Baseline Data/%s.mat',file));

data = struct2cell(data);
data = data{1};

num_IMF = 5; NR = 100; NstdMax = 0.2; NstdMin = 0.1; fs = 5000;

[y, r] = neeemd(data(1:600, :), num_IMF, NR, NstdMax, NstdMin);

for i = 1:5
    subplot(6,1,i)
    plot(y(:,i))
    set(gca,'XTick',[]);
end
subplot(6,1,6)
plot(r)
xlabel('Sample')
suptitle('NEEEMD')

