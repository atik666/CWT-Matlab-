clc;clear;

file = 'b1';
data =load(sprintf('D:/OneDrive - ump.edu.my/Atik_Home/Data Files/Blade Data/data_20150516_20hz/%s_20hz_16.mat',file));

data = data.Channel_003(1:500);

% data = struct2cell(data);
% data = data{1}(1:500);

num_IMF = 5; NR = 100; NstdMax = 0.2; NstdMin = 0.1;
[y, r] = neeemd(data, num_IMF, NR, NstdMax, NstdMin);   
%%
% for i = 1:6
%     if i == 6
%         subplot(6,1,6);
%         plot(r);
%         break;
%     end
% subplot(6,1,i);
% plot(y(:,i));
%   if i < 6
%       set(gca,'XTick',[]);
%   end   
% end
%%
x = array2table(horzcat(y,r));
x.Properties.VariableNames = {'IMF1','IMF2','IMF3','IMF4','IMF5','Res'};
stackedplot(x);
xlabel('Samples')
