% y=xlsread('some.data');       % load a signal.
% num_IMF = 5;                      % numbers of IMF
% NR = 10;                      % value of ensemble
% Nstd = 0.3;                   % param to white noise
% 
% IMF1=eemd(y,num_IMF,NR,Nstd);

function [modes,residual] = eemd(y, num_IMF, NR, NstdMax, NstdMin)
stdy = std(y);
if stdy < 0.01
    stdy = 1;
end
y = y ./ stdy;
siz = length(y);
modes = zeros(siz,num_IMF);

for k = 1:NR
    %disp(['Ensemble number #' num2str(k)]);

    Nstd = (NstdMax-NstdMin).*rand(1,1) + NstdMin; % Generating random std of white noise

    x = randn(1,siz); 
    x = x - mean(x); % genrating 0 mean and 1 std
    x = x -std(x);
    
    wn{k} = (x.*Nstd);
    
    y1 = y + wn{k};
    modes = modes + emd(y1,'MaxNumIMF',num_IMF);
end
modes = modes .* stdy ./ (NR);
residual = y - sum(modes,2);
end
