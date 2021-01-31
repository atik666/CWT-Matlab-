function output = sens(signal)

eng = EnergyFun(signal);
sumEng = sum(eng);

kurt = kurtosis(signal);

% cor = {};
% for i = 1: size(signal,2)
%     cor{i} = corrcoef(original, signal(:,i));
%     cor{i} = sum(cor{1,i}(:,1))-1;
% end
% 
% cor = cell2mat(cor);
% 
% nSignal = normalize(signal);
% ent = {};
% for i = 1: size(nSignal,2)
%     ent{i} = entropy(nSignal(:,i));
% end
% 
% ent = cell2mat(ent);

ent = {};
for i = 1: size(eng,2)
    ent{i} = (eng(:,i)./sumEng);
end

ent = cell2mat(ent);

% output = eng.*kurt.*ent;

output = kurt.*ent;

end