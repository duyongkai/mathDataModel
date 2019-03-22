clear
clc

%导入数据-[factors_rank flow_l flow_v report name1 name2]
factors_rank = zeros(17,4,28);
report = zeros(9,13,10);
for k = 1:28
    num = xlsread('data.xlsx', 1, join(['E' sprintf('%d',7+21*(k-1)) ':H' sprintf('%d',23+21*(k-1))]));
    factors_rank(:,:,k) = num;
end
for k = 1:10
    num = xlsread('data.xlsx', 3, join(['C' sprintf('%d',6+(k-1)*14) ':O' sprintf('%d',14+(k-1)*14)]));
    report(:,:,k) = num;
end
factors = zeros(16,4,28);
for k = 1:28
    factors(:,:,k) = [factors_rank(1:14,:,k); factors_rank(16:17,:,k)];
end
[num name1] = xlsread('data.xlsx', 1, 'B7:B23');
[num name2] = xlsread('data.xlsx', 2, 'C3:I3');
clearvars k num;

%-------------------TOPSIS法分析各地区水质污染状况-------------------
SA = [7.5 2 0.15; 6 4 0.5; 5 6 1; 3 10 1.5; 2 15 2];
w = [1 (SA(4,2)/SA(1,2))/(SA(4,2)/SA(1,2)+SA(4,3)/SA(1,3)) (SA(4,3)/SA(1,3))/(SA(4,2)/SA(1,2)+SA(4,3)/SA(1,3))];
c = zeros(28,21);
for k = 1:28
    A = [SA; factors(:,1:3,k)];
    Z0 = A./sqrt(sum(sum(A.^2)));
    Z = w.*Z0;
    z_max = max(Z);
    z_min = min(Z);
    s_max = sqrt(sum((Z-z_max).^2, 2));
    s_min = sqrt(sum((Z-z_min).^2, 2));
    c(k,:) = s_min./(s_min+s_max);
end
c_result = mean(c);
[transpose([repelem(0,5) 1:16]) transpose(c_result)]
result = sort(c_result, 'descend');
for k = 1:size(c,2)
    sort_num(k) = find(result==c_result(k));
end
sort_num = sort_num - 5;
for k = 1:size(c,2)
    if sort_num(k)<=0
        sort_num(k) = 0;
    end
end
[transpose(sort_num) transpose(result)]
find(c_result)
