red = xlsread('data3.xlsx', 'ºìÆÏÌÑ', 'A3:AS29');
white = xlsread('data3.xlsx', '°×ÆÏÌÑ', 'A3:AI30');
red_drink = xlsread('data3.xlsx', 'ºìÆÏÌÑ¾Æ', 'A3:AG29');
white_drink = xlsread('data3.xlsx', '°×ÆÏÌÑ¾Æ', 'A3:AF30');

corr_red = corrcoef([red red_drink]);
corr_white = corrcoef([white white_drink]);
t_red = abs(corr_red).*sqrt((size(red,1)-2)./(1-corr_red.^2));
t_white = abs(corr_white).*sqrt((size(white,1)-2)./(1-corr_white.^2));
% corr_redDrink = corrcoef(red_drink);
% corr_whiteDrink = corrcoef(white_drink);
% t_redDrink = abs(corr_redDrink).*sqrt((size(red_drink,1)-2)./(1-corr_redDrink.^2));
% t_whiteDrink = abs(corr_whiteDrink).*sqrt((size(white_drink,1)-2)./(1-corr_whiteDrink.^2));

xlswrite('output3.xlsx', corr_red, 'corr_red', 'A1');
xlswrite('output3.xlsx', t_red, 't_red', 'A1');
xlswrite('output3.xlsx', corr_white, 'corr_white', 'A1');
xlswrite('output3.xlsx', t_white, 't_white', 'A1');
% xlswrite('output3.xlsx', corr_redDrink, 'corr_redDrink', 'A1');
% xlswrite('output3.xlsx', t_redDrink, 't_redDrink', 'A1');
% xlswrite('output3.xlsx', corr_whiteDrink, 'corr_whiteDrink', 'A1');
% xlswrite('output3.xlsx', t_whiteDrink, 't_whiteDrink', 'A1');
