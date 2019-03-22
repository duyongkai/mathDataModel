clear;
clc;

%导入原始数据-[sourceData4]
sourceData4 = xlsread('E:\Users\dyk\Documents\Projects\数学建模\数模校赛\校赛题目\B题附件.xlsx', '附件4-存取款每日数据=存款-取款', 'A1:AD365');

%数据可视化：画出30个省的365个差值的散点图
for k = 1:30
    subplot(15, 2, k)
    x = sort(sourceData4(:, k));
    y = repelem(0, 365);
    plot(x, y, '*r');
end
clearvars x y k;

%数据的特征：30个省的365个差值的平均值和标准差-[mean_zones std_zones]
for k = 1:30
    mean_zones(k) = mean(sourceData4(:,k));
    std_zones(k) = std(sourceData4(:,k));
end
clearvars k;

%总体的特征：30个省的差值的平均值的平均值和标准差-[mean_total std_total]
mean_total = mean(mean_zones);
std_total = std(mean_zones);

%显示结果报告
disp('## 原始数据的总体报告');
disp('- 30个省的365个差值的平均值和标准差-[mean_zones std_zones]');
disp([transpose(mean_zones) transpose(std_zones)]);
disp('- 30个省的差值的平均值的平均值和标准差-[mean_total std_total]');
disp([mean_total std_total]);

%计算2017年各个省的备付资金
for m = 1:30
    sum_temp = 0;
    for k = 1:365
        sum_temp = sum_temp + sourceData4(k,m);
        sum_data(k) = sum_temp;
    end
    result2017(m) = -1 * min(sum_data);
end

%设置生成符合概率密度的随机数的副本数-[N]
N = 100000;

%通过随机数模拟的方法计算出各个省份在99%情况下的备付资金
for c = 1:30
    for n = 1:N
        %在一个副本内，生成一年365天的随机数
        for k = 1:365
            data_zone(k) = randn * std_zones(c);
        end
        %对365天的随机数进行累加求和
        sum_temp = 0;
        for k = 1:365
            sum_temp = sum_temp + data_zone(k);
            sum_data(k) = sum_temp;
        end
        result(n) = min(sum_data);
    end
    result_zones(c) = -1 * max(mink(result, round(N*0.1)));
    mean_result(c) = -1 * mean(result);
    std_result(c) = std(result);
end

%显示结果报告
disp('## 模拟数据分析报告');
disp('- 模拟的数据个数N');
disp(N);
disp('- 2017年30个省各自的备付资金与2018年30个省在99%置信水平下各自的备付资金、模拟值的期望、模拟值的标准差');
disp(['result2017' ' ' 'result_zones' ' ' 'mean_result' ' ' 'std_result']);
disp([transpose(result2017) transpose(result_zones) transpose(mean_result) transpose(std_result)]);
xlswrite('report.xlsx', [transpose(result2017) transpose(mean_result) transpose(std_result)], 4, 'A2');
