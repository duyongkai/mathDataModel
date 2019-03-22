clear
clc

TTI = xlsread('data.xlsx',2,'B2:B97');
time = 1:size(TTI,1);
plot(time,TTI)
title('北京市全路网TTI时序图')
xlabel('时间点')
ylabel('全路网TTI')
