clear;
clc;

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% % 使用PCA分析得出各项存贷款与宏观经济指标之间的最优线性组合
% 原始数据集的导入-[sourceData]
sourceData = xlsread('data2.xls', '葡萄酒', 'D33:CF60');

% 原始数据集的属性-[r_sourceData c_sourceData]
[r_sourceData c_sourceData] = size(sourceData);

% PCA分析的信息保留率-[set_T]
set_T = 0.9;

% 原始数据集计算对应的相关系数矩阵-[CS_sourceData]
CS_sourceData = corrcoef(sourceData);
clearvars k;

% 计算相关系数矩阵的降序排列的特征值和特征向量-[e V]
[V, D] = eig(CS_sourceData);
for k = 1:c_sourceData
    e(k) = D(c_sourceData+1-k, c_sourceData+1-k);
end

% 计算贡献率和贡献率累加-[De_rate SDe_rate]
Se_val = sum(e);
temp = 0;
for k = 1:c_sourceData
    De_rate(k) = e(k)/Se_val;
    temp = temp + De_rate(k);
    SDe_rate(k) = temp;
end

% 在符合PCA保留率的情况下提取主成分对应的特征向量-[PCA_V colNum_T]
for k = 1:c_sourceData
    if SDe_rate(k) >= set_T
        colNum_T = k;
        break;
    end
end
for k = 1:colNum_T
    PCA_V(:,k) = V(:,c_sourceData+1-k); % 一定是倒序提取！
end

% 计算各评价对象的主成分得分-[new_score]
S_sourceData = (sourceData-mean(sourceData))./std(sourceData);
new_score = S_sourceData * PCA_V;

% 总分-[total_score]
for k = 1:r_sourceData
    total_score(k, 1) = sum(new_score(k,:).*e(1:colNum_T));
end

% 输出PCA模型及结果报告
disp('# PCA分析的输出模型及结果报告');
disp('## 特征值及其贡献率、累计贡献率');
disp('### 特征值e');
disp(e);
disp('### 贡献率De');
disp(De_rate);
disp('### 累计贡献率SDe');
disp(SDe_rate);
disp('### 累计贡献率SDe');
disp('## 信息保留率对应的主成分数与特征向量');
disp('### 信息保留率T');
disp(set_T);
disp('### 满足主成分信息保留率的特征向量的列数colNum_T');
disp(colNum_T);
disp('## 主成分得分[new_score total_score]');
disp([new_score total_score]);
disp('-------------------------------------------------------------------');
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
xlswrite('output3_new_score.xlsx',new_score,'white_drink','A1');
xlswrite('output2_red.xlsx',S_sourceData,'S_sourceData','A1');
