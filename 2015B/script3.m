clear
clc

TTI = xlsread('data.xlsx',2,'B2:B97');
time = 1:size(TTI,1);
plot(time,TTI)
title('������ȫ·��TTIʱ��ͼ')
xlabel('ʱ���')
ylabel('ȫ·��TTI')
