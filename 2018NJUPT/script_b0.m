clear;
clc;

%原始数据集的导入-[[sourceData1 sourceText1] [sourceData2 sourceText2] [sourceData3 sourceText3] [sourceData4 sourceText4]]
[sourceData1, sourceText1] = xlsread('E:\Users\dyk\Documents\Projects\数学建模\数模校赛\校赛题目\B题附件.xlsx', '附件1-宏观经济指标', 'A3:U35');
[sourceData2, sourceText2] = xlsread('E:\Users\dyk\Documents\Projects\数学建模\数模校赛\校赛题目\B题附件.xlsx', '附件2-各项存贷款历史数据', 'A3:H32');
[sourceData3, sourceText3] = xlsread('E:\Users\dyk\Documents\Projects\数学建模\数模校赛\校赛题目\B题附件.xlsx', '附件3-存贷款利率水平', 'A15:H44');
[sourceData4, sourceText4] = xlsread('E:\Users\dyk\Documents\Projects\数学建模\数模校赛\校赛题目\B题附件.xlsx', '附件4-存取款每日数据', 'A4:CM368');

%数据集1(宏观经济指标)的可视化
s1 = size(sourceText1);
s2 = size(sourceData1);
sourceText1_v1 = 1:s1(1);
for k = 1:s2(2)
    subplot(4, ceil(s2(2)/4), k);
    plot(sourceText1_v1, sourceData1(:,k), '*r');
end
clearvars s1 s2 sourceText1_v1 k;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clear;
clc;

%%使用PCA分析得出各项存贷款与宏观经济指标之间的最优线性组合
%原始数据集的导入-[[sourceData1 sourceText1] [sourceData2 sourceText2] [sourceData3 sourceText3] [sourceData4 sourceText4]]
[sourceData1, sourceText1] = xlsread('E:\Users\dyk\Documents\Projects\数学建模\数模校赛\校赛题目\B题附件.xlsx', '附件1-宏观经济指标', 'A3:U35');
[sourceData2, sourceText2] = xlsread('E:\Users\dyk\Documents\Projects\数学建模\数模校赛\校赛题目\B题附件.xlsx', '附件2-各项存贷款历史数据', 'A3:H32');
[sourceData3, sourceText3] = xlsread('E:\Users\dyk\Documents\Projects\数学建模\数模校赛\校赛题目\B题附件.xlsx', '附件3-存贷款利率水平', 'A15:H44');
[sourceData4, sourceText4] = xlsread('E:\Users\dyk\Documents\Projects\数学建模\数模校赛\校赛题目\B题附件.xlsx', '附件4-存取款每日数据', 'A4:CM368');

%原始数据集的属性-[r_sourceData1 c_sourceData1]
[r_sourceData1 c_sourceData1] = size(sourceData1);

%根据原始数据构造出的便于处理的数据

%PCA分析的信息保留率-[set_T]
set_T = 0.9;

%标准化原始数据集并计算对应的相关系数矩阵-[S_sourceData1 CS_sourceData1]
for k = 1:c_sourceData1
    S_sourceData1(:,k) = (sourceData1(:,k) - mean(sourceData1(:,k)))/std(sourceData1(:,k));
end
CS_sourceData1 = corrcoef(S_sourceData1);
clearvars k;

%计算相关系数矩阵的降序排列的特征值和特征向量-[e V]
[V, D] = eig(CS_sourceData1)
for k = 1:c_sourceData1
    e(k) = D(c_sourceData1+1-k, c_sourceData1+1-k);
end
clearvars D k;

%计算贡献率和贡献率累加-[De_rate SDe_rate]
Se_val = sum(e);
temp = 0;
for k = 1:c_sourceData1
    De_rate(k) = e(k)/Se_val;
    temp = temp + De_rate(k);
    SDe_rate(k) = temp;
end
clearvars k temp Se_val;

%在符合PCA保留率的情况下提取主成分对应的特征向量-[PCA_V colNum_T]
for k = 1:c_sourceData1
    if SDe_rate(k) >= set_T
        colNum_T = k;
        break;
    end
end
for k = 1:colNum_T
    PCA_V(:,k) = V(:,c_sourceData1+1-k); %一定是倒序提取！
end
clearvars k;

%计算各评价对象的主成分得分-[new_score]
new_score = S_sourceData1 * PCA_V;

%

%输出PCA模型及结果报告
disp('# PCA分析的输出模型及结果报告');
disp('-------------------------------------------------------------------');
disp('## 特征值及其贡献率、累计贡献率');
disp('### 特征值e');
disp(e);
disp('### 贡献率De');
disp(De_rate);
disp('### 累计贡献率SDe');
disp(SDe_rate);
disp('-------------------------------------------------------------------');
disp('## 信息保留率对应的主成分数与特征向量');
disp('### 信息保留率T');
disp(set_T);
disp('### 满足主成分信息保留率的特征向量的列数colNum_T');
disp(colNum_T);
disp('### 主成分下的特征向量PV');
disp(PCA_V);
disp('-------------------------------------------------------------------');
disp('## 主成分得分');
disp(new_score);







%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
clc;

%%使用PCA分析得出各项存贷款与宏观经济指标之间的最优线性组合
%原始数据集的导入-[[sourceData1 sourceText1] [sourceData2 sourceText2] [sourceData3 sourceText3] [sourceData4 sourceText4]]
[sourceData1, sourceText1] = xlsread('E:\Users\dyk\Documents\Projects\数学建模\数模校赛\校赛题目\B题附件.xlsx', '附件1-宏观经济指标', 'A3:U35');
[sourceData2, sourceText2] = xlsread('E:\Users\dyk\Documents\Projects\数学建模\数模校赛\校赛题目\B题附件.xlsx', '附件2-各项存贷款历史数据', 'A3:H32');

%原始数据集的属性-[[r_sourceData1 c_sourceData1] [r_sourceData2 c_sourceData2]]
[r_sourceData1 c_sourceData1] = size(sourceData1);
[r_sourceData2 c_sourceData2] = size(sourceData2);

%标准化原始数据集并计算对应的相关系数矩阵-[S_sourceData1 CS_sourceData1]
for k = 1:c_sourceData1
    S_sourceData1(:,k) = (sourceData1(:,k) - mean(sourceData1(:,k)))/std(sourceData1(:,k));
end
CS_sourceData1 = corrcoef(S_sourceData1);
clearvars k;

%计算相关系数矩阵的降序排列的特征值和特征向量-[e]
e = eig(CS_sourceData1)
s = size(D, 1);
for k = 1:s
    e(k) = D(k, k);
end
e
clearvars V D k s;
size(sourceData1)
%求出存款的系数
for k = 1:r_sourceData1
    z0(k) = sourceData1(k, :) * transpose(e);
end
z0
m = 0;
for k = 1:4:(r_sourceData1-3)
    m = m+1;
    z1(m) = mean(z0(k:k+3));
end
z1
m = 0;
n = (size(z1,2)-2):size(z1,2);
for k = 3:2:7
    m = m+1;
    z2(m) = sum(sourceData2(:,k))/z1(n(m));
end
z2
p = z1(n) .* z2

%输出PCA模型及结果报告
disp('# PCA分析的输出模型及结果报告');
disp('-------------------------------------------------------------------');
disp('## 特征值e');
disp(e);
disp('## z0');
disp(z0);
