clear
clc

%设置全局变量[year_num3 x_num]
year_num3 = 10;
x_num = 6;

%导入数据[report y]
report = zeros(9,13,10);
for k = 1:10
    num = xlsread('data.xlsx', 3, join(['C' sprintf('%d',6+(k-1)*14) ':O' sprintf('%d',14+(k-1)*14)]));
    report(:,:,k) = num;
end
y = transpose([174 179 183 189 207 234 220.5 256 270 285]);

%---------------------对于水文年的全流域的多元回归分析-它们之间没有多重共线性---------------------%
%整理本次用到的数据[x_mat]
x_mat = zeros(year_num3, x_num);
for m = 1:year_num3
    for n = 1:x_num
        x_mat(m,n) = report(7, (2+2*(n-1)), m);
    end
end

% %单个类别对总污染物的回归可视化
% figure('Name','单个类别对总污染物的回归可视化')
% for k = 1:x_num
%     subplot(3,2,k)
%     p = polyfit(x_mat(:,k),y,1);
%     xi = 0:0.1:(max(x_mat(:,k))+100);
%     yi = polyval(p,xi);
%     plot(x_mat(:,k),y,'*')
%     hold on
%     plot(xi,yi)
%     hold off
%     title(join(['x' sprintf('%d',k) '-y']))
% end

% %线性关系的显著性检验
% [b bint r rint stats] = regress(y, [ones(year_num3,1) x_mat])
% sb = sqrt(stats(4))./sqrt(sum(x_mat.^2)-(1/year_num3).*sum(x_mat).^2);
% tb = transpose(b(2:x_num+1))./sb

%单个类别对总污染物的时间序列可视化
figure('Name','单个类别对总污染物的时间序列可视化')
for k = 1:x_num
    subplot(3,2,k)
    xi = 1:year_num3;
    yi = x_mat(:,k);
    plot(xi, yi, '--')
    hold on
    % % 线性关系的显著性检验
    % [b bint r rint stats] = regress(yi', [ones(year_num3,1) xi'])
    % sb = sqrt(stats(4))./sqrt(sum(xi.^2)-(1/year_num3).*sum(xi).^2);
    % tb = transpose(b(2:x_num+1))./sb
    % disp(k)
    % disp(stats)
    % disp(tb)
    % disp('-----------------------')
    % p = polyfit(xi,transpose(yi),1);
    % xi = 1:0.1:year_num3;
    % yi = polyval(p,xi);
    % plot(xi,yi)
    % title(join(['t-' 'x' sprintf('%d',k)]))
end
