% clear
% clc

% 导入获取的数据
base_TTI_mat = xlsread('data.xlsx',2,'C2:F97');

% 设置全局参数
NTS = 500; % 比例尺
area_div = [32 48 64 96].*1000/NTS; % 北京市不同拥堵区域的坐标划分,这里是从2环依次划分到5环，单位为米(我想安区划分) 周长
ave_people_num = 10; % 假设全城每个最小单位的打车需求人数的平均值，在此条件下假设某地的某时刻的打车需求人数满足标准正态分布，并且假设打车的需求人数在全程内大致是分布均匀的
rate_taxiArrive = 1; % 假设司机的到达率为100%
TTI = 1; % 交通指数
rORc = 48; % 将交通网络划分为rORc*rORc的线，假设北京是正方形，那么NTS=1000对应rORc=24且为反比关系
wait_time = 6; % 单位为min
experience = 0.5; % 假设司机的经验为常数0.5

count = zeros(size(base_TTI_mat,1),3);
start_points_sum = zeros(size(base_TTI_mat,1),1);
% 生成交通网络图的邻接矩阵
for time_p = 1:size(base_TTI_mat,1)
    base_TTI = base_TTI_mat(time_p,:);
    road_net = zeros(0);
    time_net = zeros(0);
    for k = 1:rORc
        time_ri = zeros(area_div(4)/4);
        road_ri = zeros(area_div(4)/4);
        for ki = 1:size(time_ri,1)-1
            if rORc-ki >= 16 & rORc-ki <= 32
                TTI = base_TTI(1);
            end
            if (rORc-ki >= 12 & rORc-ki < 16) | (rORc-ki <= 36 & rORc-ki > 32)
                TTI = base_TTI(2);
            end
            if (rORc-ki >= 8 & rORc-ki < 12) | (rORc-ki <= 40 & rORc-ki > 36)
                TTI = base_TTI(3);
            end
            if (rORc-ki >= 0 & rORc-ki < 8) | (rORc-ki <= 48 & rORc-ki > 40)
                TTI = base_TTI(4);
            end
            road_ri(ki,ki+1) = NTS;
            time_ri(ki,ki+1) = NTS/(-2.1*TTI+37);
        end
        for ki = 1:size(time_ri,2)-1
            road_ri(ki+1,ki) = road_ri(ki,ki+1);
            time_ri(ki+1,ki) = time_ri(ki,ki+1);
        end
        time_net = blkdiag(time_net,time_ri);
        road_net = blkdiag(road_net,road_ri);
    end
    for m = 1:(size(road_net,1)/size(time_ri,1)-1)
        for n = 1:size(time_ri,1)
            if rORc-n >= 16 & rORc-n <= 32
                TTI = base_TTI(1);
            end
            if (rORc-n >= 12 & rORc-n < 16) | (rORc-n <= 36 & rORc-n > 32)
                TTI = base_TTI(2);
            end
            if (rORc-n >= 8 & rORc-n < 12) | (rORc-n <= 40 & rORc-n > 36)
                TTI = base_TTI(3);
            end
            if (rORc-n >= 0 & rORc-n < 8) | (rORc-n <= 48 & rORc-n > 40)
                TTI = base_TTI(4);
            end
            road_net(size(time_ri,1)*(m-1)+n,size(time_ri,1)*m+n) = NTS;
            time_net(size(time_ri,1)*(m-1)+n,size(time_ri,1)*m+n) = NTS/(-2.1*TTI+37);
            road_net(size(time_ri,1)*m+n,size(time_ri,1)*(m-1)+n) = road_net(size(time_ri,1)*(m-1)+n,size(time_ri,1)*m+n);
            time_net(size(time_ri,1)*m+n,size(time_ri,1)*(m-1)+n) = time_net(size(time_ri,1)*(m-1)+n,size(time_ri,1)*m+n);
        end
    end
    % 将数据写入到表格中
    % xlswrite('result1_road_net.xlsx',road_net,time_p,'A1');
    % xlswrite('result1_time_net.xlsx',time_net,time_p,'A1');

    % 生成交通网络图
    road_network = graph(road_net);
    time_network = graph(time_net);
    figure('Name','road_network')
    plot(road_network)
    % figure('Name','time_network')
    % plot(time_network)

    % 求最短时间
    shortest_time_mat = distances(time_network);
    % 求最短路程
    shortest_road_mat = distances(road_network);
    % 将数据写入到表格中
    % xlswrite('result1_shortestTimeMat.xlsx',shortest_time_mat,time_p,'A1');
    % xlswrite('result1_shortestTimeMat.xlsx',shortest_road_mat,time_p,'A1');

    % 计算评价指标p
    w = shortest_time_mat./(wait_time*rate_taxiArrive); % 这种算法的确定是速度会偏大
    sum_p = sum(sum(exp(-experience.*(shortest_time_mat+w))))/2;
    p = exp(-experience.*(shortest_time_mat+w))./sum(exp(-experience.*(shortest_time_mat+w)));
    % 将数据写入到表格中
    % xlswrite('result_w.xlsx',w,time_p,'A1');
    % xlswrite('result_p.xlsx',p,time_p,'A1');

    % 生成上一个出发点打车的截面出租车需求的矩阵初始网格(Oi)
    m = 1;
    n = 1;
    for m = 1:rORc
        for n = 1:rORc
            while true
                pointi = round(ave_people_num.*rand*randn);
                if pointi >= 0
                    start_points(m,n) = pointi;
                    break;
                end
            end
        end
    end
    start_points_sum(time_p) = sum(sum(start_points));
    % 将数据写入到表格中
    % xlswrite('result1_startPoints.xlsx',start_points,time_p,'A1');

    % 生成上一个出发点打车的截面出租车需求的矩阵初始网格(Di)
    m = 1;
    n = 1;
    for m = 1:rORc
        for n = 1:rORc
            while true
                pointi = round(ave_people_num.*rand*randn);
                if pointi >= 0
                    end_points(m,n) = pointi;
                    break;
                end
            end
        end
    end
    % 将数据写入到表格中
    % xlswrite('result1_endPoints.xlsx',end_points,time_p,'A1');

    m = 1;
    n = 1;
    k_reduce = 0;
    k_add = 0;
    k_zero = 0;
    for m = 1:rORc
        for n = 1:rORc
            score(m,n) = sum(end_points(m,n).*p(:,m))-start_points(m,n);
            if score(m,n) < 0
                k_reduce = k_reduce+1;
            end
            if score(m,n) > 0
                k_add = k_add+1;
            end
            if score(m,n) == 0
                k_zero = k_zero+1;
            end
        end
    end
    count(time_p,:) = [k_add k_reduce k_zero];
    % 将数据写入到表格中
    % xlswrite('result.xlsx',score,time_p,'A1');
end

% 对时间维度上的频数分析
% plot(1:size(count,1),count(:,1))
% hold on
% plot(1:size(count,1),count(:,2))
% plot(1:size(count,1),count(:,3))
% xlswrite('result1_count.xlsx',count,1,'A1');

% 对在没有调度情况下的打车需求的情况分析
% xlswrite('result_startPointsSum.xlsx',start_points_sum,1,'A1');
plot(1:size(base_TTI_mat,1),start_points_sum)
