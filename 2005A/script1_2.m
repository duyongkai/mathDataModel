clear
clc

%设置全局变量
city_num1 = 17;
month_num1 = 28;
factors_num = 3;
grade_num = 5;

%导入数据
factors = zeros(city_num1, factors_num, month_num1);
for k = 1:month_num1
    num = xlsread('data.xlsx', 1, join(['E' sprintf('%d',7+21*(k-1)) ':G' sprintf('%d',23+21*(k-1))]));
    factors(:,:,k) = num;
end

%-------------------TOPSIS法分析各地区水质污染状况-------------------%
SA = [7.5 2 0.15; 6 4 0.5; 5 6 1; 3 10 1.5; 2 15 2];
w = [1 (SA(4,2)/SA(1,2))/(SA(4,2)/SA(1,2)+SA(4,3)/SA(1,3)) (SA(4,3)/SA(1,3))/(SA(4,2)/SA(1,2)+SA(4,3)/SA(1,3))];
c = zeros(month_num1,city_num1+grade_num);
for k = 1:month_num1
    A = [SA; factors(:,:,k)];
    Z0 = A./sqrt(sum(sum(A.^2)));
    Z = w.*Z0;
    z_max = max(Z);
    z_min = min(Z);
    s_max = sqrt(sum((Z-z_max).^2, 2));
    s_min = sqrt(sum((Z-z_min).^2, 2));
    c(k,:) = s_min./(s_min+s_max);
end
c_result = mean(c);
result = [transpose([repelem(0,grade_num) 1:city_num1]) transpose(c_result)]
xlswrite('data.xlsx', c(:,6:22), 4, 'A1');
