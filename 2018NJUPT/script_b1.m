clear;
clc;

%%使用PCA分析得出各项存贷款与宏观经济指标之间的最优线性组合
%原始数据集的导入-[[sourceData1 sourceText1] [sourceData2 sourceText2] [sourceData3 sourceText3] [sourceData4 sourceText4]]
[sourceData1, sourceText1] = xlsread('E:\Users\dyk\Documents\Projects\数学建模\数模校赛\校赛题目\B题附件.xlsx', '附件1-宏观经济指标', 'A3:U34');
[sourceData2, sourceText2] = xlsread('E:\Users\dyk\Documents\Projects\数学建模\数模校赛\校赛题目\B题附件.xlsx', '附件2-各项存贷款历史数据', 'A3:H32');

%原始数据集的属性-[[r_sourceData1 c_sourceData1] [r_sourceData2 c_sourceData2]]
[r_sourceData1 c_sourceData1] = size(sourceData1);
[r_sourceData2 c_sourceData2] = size(sourceData2);

%PCA分析的信息保留率-[set_T]
set_T = 0.95;

%原始数据集计算对应的相关系数矩阵-[CS_sourceData1]
CS_sourceData1 = corrcoef(sourceData1);
clearvars k;

%计算相关系数矩阵的降序排列的特征值和特征向量-[e V]
[V, D] = eig(CS_sourceData1);
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
new_score = sourceData1 * PCA_V;

%季度总分-[total_score]
for k = 1:r_sourceData1
    total_score(k, 1) = sum(new_score(k,:).*e(1:colNum_T));
end
clearvars k;

%年度总分-[total_score_year]
m = 0;
for k = 1:4:(r_sourceData1-3)
    m = m+1;
    total_score_year(m) = mean(total_score(k:k+3));
end
clearvars m k;

%存款历史数据对应的年度总分除存款数据得出比例-[p Pi_in Pi_out p_in p_out]
n = (size(total_score_year,2)-2):size(total_score_year,2);
m = 0;
for k = 3:2:7
    m = m+1;
    p_in(m) = sum(sourceData2(:,k))/total_score_year(n(m));
end
m = 0;
for k = 4:2:8
    m = m+1;
    p_out(m) = sum(sourceData2(:,k))/total_score_year(n(m));
end
pi_in = mean(p_in);
pi_out = mean(p_out);
clearvars m k n;

%得出六个主成分对应的比例-[pi_PCA po_PCA]
pi_PCA = pi_in * e(1:colNum_T);
po_PCA = pi_out * e(1:colNum_T);

%输出PCA模型及结果报告
disp('# PCA分析的输出模型及结果报告');
disp('## 特征值及其贡献率、累计贡献率');
disp('### 特征值e');
disp(e);
% xlswrite('E:\Users\dyk\Documents\Projects\数学建模\数模校赛\code\report.xlsx', e, 1, 'B1');
disp('### 贡献率De');
disp(De_rate);
% xlswrite('E:\Users\dyk\Documents\Projects\数学建模\数模校赛\code\report.xlsx', De_rate, 1, 'B2');
disp('### 累计贡献率SDe');
disp(SDe_rate);
% xlswrite('E:\Users\dyk\Documents\Projects\数学建模\数模校赛\code\report.xlsx', SDe_rate, 1, 'B3');
disp('### 累计贡献率SDe');
disp('## 信息保留率对应的主成分数与特征向量');
disp('### 信息保留率T');
disp(set_T);
% xlswrite('E:\Users\dyk\Documents\Projects\数学建模\数模校赛\code\report.xlsx', set_T, 1, 'B4');
disp('### 满足主成分信息保留率的特征向量的列数colNum_T');
disp(colNum_T);
% xlswrite('E:\Users\dyk\Documents\Projects\数学建模\数模校赛\code\report.xlsx', colNum_T, 1, 'B5');
disp('### 主成分下的特征向量PV');
disp(PCA_V);
% xlswrite('E:\Users\dyk\Documents\Projects\数学建模\数模校赛\code\report.xlsx', PCA_V, 1, 'B6');
disp('## 主成分得分[new_score total_score]');
disp([new_score total_score]);
% xlswrite('E:\Users\dyk\Documents\Projects\数学建模\数模校赛\code\report.xlsx', [new_score total_score], 1, 'B27');
disp('## 对于PCA分析构造出来的总分与现实存款贷款的三年的三个比例系数');
disp('### 存款p_in');
disp(p_in);
% xlswrite('E:\Users\dyk\Documents\Projects\数学建模\数模校赛\code\report.xlsx', p_in, 1, 'B60');
disp('### 贷款p_out');
disp(p_out);
% xlswrite('E:\Users\dyk\Documents\Projects\数学建模\数模校赛\code\report.xlsx', p_out, 1, 'B61');
disp('## 对于PCA分析构造出来的总分与现实存款贷款的最终平均的比例系数');
disp('### 存款pi_in');
disp(pi_in);
% xlswrite('E:\Users\dyk\Documents\Projects\数学建模\数模校赛\code\report.xlsx', pi_in, 1, 'B62');
disp('### 贷款pi_out');
disp(pi_out);
% xlswrite('E:\Users\dyk\Documents\Projects\数学建模\数模校赛\code\report.xlsx', pi_out, 1, 'B63');
disp('## 对于PCA分析构造出来的分量得分的最终的比例系数');
disp('### 存款pi_PCA');
disp(pi_PCA);
% xlswrite('E:\Users\dyk\Documents\Projects\数学建模\数模校赛\code\report.xlsx', pi_PCA, 1, 'B64');
disp('### 贷款po_PCA');
disp(po_PCA);
% xlswrite('E:\Users\dyk\Documents\Projects\数学建模\数模校赛\code\report.xlsx', po_PCA, 1, 'B65');
disp('-------------------------------------------------------------------');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%原始数据集的导入-[[sourceData1 sourceText1] [sourceData2 sourceText2] [sourceData3 sourceText3] [sourceData4 sourceText4]]
[sourceData1, sourceText1] = xlsread('E:\Users\dyk\Documents\Projects\数学建模\数模校赛\校赛题目\B题附件.xlsx', '附件1-宏观经济指标', 'A3:U35');
clearvars sourceText1;

%原始数据集的属性-[r_sourceData1 c_sourceData1]
[r_sourceData1 c_sourceData1] = size(sourceData1);

%计算相关系数矩阵的降序排列的特征值和特征向量-[V]
[V, D] = eig(CS_sourceData1);
clearvars D;

%提取主成分对应的特征向量-[PCA_V]
for k = 1:colNum_T
    PCA_V(:,k) = V(:,c_sourceData1+1-k); %一定是倒序提取！
end
clearvars k;

%计算各评价对象的主成分得分-[new_score]
new_score = sourceData1 * PCA_V;

%季度存款和贷款总分-[total_score_in total_score_out]
for k = 1:r_sourceData1
    total_score_in(k, 1) = sum(new_score(k,:).*pi_PCA);
end
for k = 1:r_sourceData1
    total_score_out(k, 1) = sum(new_score(k,:).*po_PCA);
end
clearvars k;

%年度存款和贷款总分-[total_score_yearIn total_score_yearOut]
m = 0;
for k = 1:4:(r_sourceData1-3)
    m = m+1;
    total_score_yearIn(m) = mean(total_score_in(k:k+3));
end
m = 0;
for k = 1:4:(r_sourceData1-3)
    m = m+1;
    total_score_yearOut(m) = mean(total_score_out(k:k+3));
end
clearvars m k;

%输出检验和预测的结果报告
disp('# 检验以及预测值的主成分得分总分');
disp('## 季度度存款检验    季度贷款检验');
disp('total_score_in    total_score_out');
disp([total_score_in(1:numel(total_score_in)-1, 1) total_score_out(1:numel(total_score_out)-1, 1)]);
disp('## 年度存款检验   年度贷款检验');
disp('total_score_yearIn    total_score_yearOut');  
disp([transpose(total_score_yearIn) transpose(total_score_yearOut)]);
% xlswrite('E:\Users\dyk\Documents\Projects\数学建模\数模校赛\code\report.xlsx', [transpose(total_score_yearIn) transpose(total_score_yearOut)], 1, 'B66');
disp('2018 年度存款预测    年度贷款预测');
disp([total_score_in(numel(total_score_in)) total_score_out(numel(total_score_out))]);
disp('-------------------------------------------------------------------');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%误差分析%%%%%%%%%%%%%%%%%%%%%%

residual = xlsread('E:\Users\dyk\Documents\Projects\数学建模\数模校赛\校赛题目\B题附件.xlsx', '附件2-各项存贷款历史数据', 'C35:H35');
residual_in = residual(1:2:6);
residual_out = residual(2:2:6);
time_serious = [2015 2016 2017];

subplot(1, 2, 1);
bar(time_serious, residual_in);
xlabel('年份');
ylabel('额度');
title('存款的残差分析图');
subplot(1, 2, 2);
bar(time_serious, residual_out);
xlabel('年份');
ylabel('额度');
title('贷款的残差分析图');
disp('# 误差分析');
disp('- 2015-2017年存款的残差');
disp(residual_in);
disp('- 2015-2017年贷款的残差');
disp(residual_out);
disp('- 2015-2017年存款的残差均值');
disp(mean(residual_in));
disp('- 2015-2017年存款的残差的标准差');
disp(std(residual_in));
disp('- 2015-2017年贷款的残差均值');
disp(mean(residual_out));
disp('- 2015-2017年存款的残差的标准差');
disp(std(residual_in));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
