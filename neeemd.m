% y=xlsread('some.data');       % load a signal.
% num_IMF = 5;                      % numbers of IMF
% NR = 10;                      % value of ensemble
% Nstd = 0.3;                   % param to white noise
% 
% IMF1=eemd(y,num_IMF,NR,Nstd);

function [Fimfs, residual] = neeemd(y, num_IMF, NR, NstdMax, NstdMin)
stdy = std(y);
if stdy < 0.01
    stdy = 1;
end
y = y ./ stdy;
siz = length(y);
modes = zeros(siz,num_IMF);
res = zeros(siz,1);
for k = 1:NR
    disp(['Ensemble number #' num2str(k)]);

    Nstd = (NstdMax-NstdMin).*rand(1,1) + NstdMin; % Generating random std of white noise
    
    x = randn(siz,1);
    x = x - mean(x); % genrating 0 mean and 1 std
    x = x -std(x);
    
    wn{k} = x.*Nstd;
    
    noise{1,k} = wn{k};
    
    y1 = y + wn{k};
    [imf, resN] = emd(y1,'MaxNumIMF',num_IMF); % obtaining IMFs and residuals
    modes = modes + imf;
    res = res + resN; 
end
modes = modes .* stdy ./ (NR); % IMFs from EEMD
res = res ./ NR; % Final residuals
% dealing with the noise
Nimfs = zeros(siz,num_IMF);
nres = zeros(siz,1);
for i = 1:NR
    [nimfs, nresN] = emd(noise{1,i},'MaxNumIMF',num_IMF);
    Nimfs = Nimfs+nimfs;
    nres = nres + nresN;
end
Nimfs = Nimfs./NR; % IMFs of noise
Fimfs = modes - Nimfs; % Final IMFs of nEEEMD.
nres = nres ./ NR; % Noise residual
residual = res - nres; % Residue of signal
end