clear
clc

%设置全局变量
month_num1 = 28;
city_num1 = 17;
x_num = 4;

%导入数据
factors_rank = zeros(city_num1,x_num+1,month_num1);
for k = 1:month_num1
    num = xlsread('data.xlsx', 1, join(['D' sprintf('%d',7+21*(k-1)) ':H' sprintf('%d',23+21*(k-1))]));
    factors_rank(:,:,k) = num;
end
score = xlsread('data.xlsx', 4, 'A1:Q28');

% %数据回归
% b_mat = zeros(month_num1,4);
% tb_mat = zeros(month_num1,4);
% for k = 1:month_num1
%     factors = zeros(city_num1,4);
%     factors = factors_rank(:,1:4,k);
%     x = [ones(city_num1,1) factors];
%     grades = zeros(city_num1,1);
%     grades = factors_rank(:,5,k);
%     [b bint r rint stats] = regress(grades, x);
%     sb = sqrt(stats(4))./sqrt(sum(factors.^2)-(1/city_num1).*sum(factors).^2);
%     tb = transpose(b(2:x_num+1))./sb;
%     b_mat(k,:) = b(2:5);
%     tb_mat(k,:) = tb;
% end
% b_mean = mean(b_mat);
% tb_mean = mean(tb_mat);
% [b_mean; tb_mean]

%数据回归
factors_l = zeros(month_num1,x_num);
score_l = zeros(month_num1,1);
for k = 1:month_num1
    factors = zeros(city_num1,x_num);
    factors = factors_rank(:,1:x_num,k);
    S_factors = (factors-mean(factors))./std(factors);
    factors_l(k,:) = mean(S_factors);
    score_l(k,1) = sum(score(k,:));
end
[b bint r rint stats] = regress(score_l, [ones(month_num1,1) factors_l]);
sb = sqrt(stats(4))./sqrt(sum(factors.^2)-(1/city_num1).*sum(factors).^2);
tb = transpose(b(2:x_num+1))./sb;
[b' tb]
