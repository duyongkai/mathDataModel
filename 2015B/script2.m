clear
clc

% ��������
data2 = xlsread('data2_1_1.xlsx',1,'B2:E1001');

% �������ϵ��
R = corrcoef(data2);
