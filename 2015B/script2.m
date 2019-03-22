clear
clc

% 导入数据
data2 = xlsread('data2_1_1.xlsx',1,'B2:E1001');

% 计算相关系数
R = corrcoef(data2);
