circle2 = zeros(area_div(1));
circle3 = zeros(area_div(2));
circle4 = zeros(area_div(3));
circle5 = zeros(area_div(4));
G108 = zeros(area_div(4)/4);
% 二环图
for k = 1:area_div(1)-1
    circle2(k,k+1) = TTI;
end
circle2(area_div(1),1) = TTI;
diag_1 = diag(circle2,1);
for k = 1:area_div(1)-1
    circle2(k+1,k) = diag_1(k);
end
circle2(1,area_div(1)) = circle2(area_div(1),1);
% 三环图
for k = 1:area_div(2)-1
    circle3(k,k+1) = TTI;
end
circle3(area_div(2),1) = TTI;
diag_1 = diag(circle3,1);
for k = 1:area_div(2)-1
    circle3(k+1,k) = diag_1(k);
end
circle3(1,area_div(2)) = circle3(area_div(2),1);
% 四环图
for k = 1:area_div(3)-1
    circle4(k,k+1) = TTI;
end
circle4(area_div(3),1) = TTI;
diag_1 = diag(circle4,1);
for k = 1:area_div(3)-1
    circle4(k+1,k) = diag_1(k);
end
circle4(1,area_div(3)) = circle4(area_div(3),1);
% 五环图
for k = 1:area_div(4)-1
    circle5(k,k+1) = TTI;
end
circle5(area_div(4),1) = TTI;
diag_1 = diag(circle5,1);
for k = 1:area_div(4)-1
    circle5(k+1,k) = diag_1(k);
end
circle5(1,area_div(4)) = circle5(area_div(4),1);
% 所有环路
circle0 = blkdiag(circle2,circle3,circle4,circle5);
% G108
for k = 1:size(G108,1)-1
    G108(k,k+1) = TTI;
end
for k = 1:size(G108,2)-1
    G108(k+1,k) = diag_1(k);
end

% G108和二环的交点
% circle_len_temp = 10;
% road_net(circle_len_temp,size(circle0,1)+round(size(G108,1)/2-size(circle2,1)/8)) = TTI;
% % road_net(circle_len_temp,size(circle0,1)+round(size(G108,1)/2+size(circle2,1)/8)) = TTI;
% road_net(size(circle0,1)+round(size(G108,1)/2-size(circle2,1)/8),circle_len_temp) = road_net(circle_len_temp,size(circle0,1)+round(size(G108,1)/2-size(circle2,1)/8));
% road_net(size(circle0,1)+round(size(G108,1)/2+size(circle2,1)/8),circle_len_temp) = road_net(circle_len_temp,size(circle0,1)+round(size(G108,1)/2+size(circle2,1)/8));
% G108和三环的交点
% circle_len_temp = circle_len_temp+size(circle2,1);
% road_net(circle_len_temp,size(circle0,1)+round(size(G108,1)/2-size(circle3,1)/8)) = TTI;
% road_net(circle_len_temp,size(circle0,1)+round(size(G108,1)/2+size(circle3,1)/8)) = TTI;
% road_net(size(circle0,1)+round(size(G108,1)/2-size(circle3,1)/8),circle_len_temp) = road_net(circle_len_temp,size(circle0,1)+round(size(G108,1)/2-size(circle3,1)/8));
% road_net(size(circle0,1)+round(size(G108,1)/2+size(circle3,1)/8),circle_len_temp) = road_net(circle_len_temp,size(circle0,1)+round(size(G108,1)/2+size(circle3,1)/8));
% G108和四环的交点
% circle_len_temp = circle_len_temp+size(circle3,1);
% road_net(circle_len_temp,size(circle0,1)+round(size(G108,1)/2-size(circle4,1)/8)) = TTI;
% road_net(circle_len_temp,size(circle0,1)+round(size(G108,1)/2+size(circle4,1)/8)) = TTI;
% road_net(size(circle0,1)+round(size(G108,1)/2-size(circle4,1)/8),circle_len_temp) = road_net(circle_len_temp,size(circle0,1)+round(size(G108,1)/2-size(circle4,1)/8));
% road_net(size(circle0,1)+round(size(G108,1)/2+size(circle4,1)/8),circle_len_temp) = road_net(circle_len_temp,size(circle0,1)+round(size(G108,1)/2+size(circle4,1)/8));
% G108和五环的交点
% circle_len_temp = circle_len_temp+size(circle4,1);
% road_net(circle_len_temp,size(circle0,1)+round(size(G108,1)/2-size(circle5,1)/8)) = TTI;
% road_net(circle_len_temp,size(circle0,1)+round(size(G108,1)/2+size(circle5,1)/8)) = TTI;
% road_net(size(circle0,1)+round(size(G108,1)/2-size(circle5,1)/8),circle_len_temp) = road_net(circle_len_temp,size(circle0,1)+round(size(G108,1)/2-size(circle5,1)/8));
% road_net(size(circle0,1)+round(size(G108,1)/2+size(circle5,1)/8),circle_len_temp) = road_net(circle_len_temp,size(circle0,1)+round(size(G108,1)/2+size(circle5,1)/8));

% 背景划分数据化网格生成及初始化
% map_grid = zeros(mapLen_x/min_mapGrid_len, mapLen_y/min_mapGrid_len);
people_startDiv_grid = zeros(mapLen_x/people_divGrid_len, mapLen_y/people_divGrid_len);
people_endDiv_grid = zeros(mapLen_x/people_divGrid_len, mapLen_y/people_divGrid_len);

% 生成上一个出发点打车的截面出租车需求的矩阵初始网格(Oi)[people_startDiv_grid]
m = 1;
n = 1;
for m = 1:size(people_startDiv_grid, 1)
    for n = 1:size(people_startDiv_grid, 2)
        while true
            people_div_point = round(ave_people_num.*rand*randn);
            if people_div_point >= 0
                people_startDiv_grid(m,n) = people_div_point;
                break;
            end
        end
    end
end

% Dj辆空载出租车的矩阵初始网格(Dj)[people_endDiv_grid]
m = 1;
n = 1;
for m = 1:size(people_endDiv_grid, 1)
    for n = 1:size(people_endDiv_grid, 2)
        while true
            people_div_point = round(ave_people_num.*rand*randn);
            if people_div_point >= 0
                people_endDiv_grid(m,n) = people_div_point;
                break;
            end
        end
    end
end

% 用数据画出地图中的道路
area_div = [8 12 16 24].*1000; % 北京市不同拥堵区域的坐标划分,这里是从2环依次划分到5环，单位为米(我想安区划分)
% 画出五环的坐标
TTI = 1; % 北
for k = mapLen_y-area_div(4)+1:area_div(4)
    map_grid(1:wide1,k) = TTL;
    if mod(k,100) == 0
        TTL = rand;
    end
end
TTI = 1; % 南
for k = mapLen_y-area_div(4)+1:area_div(4)
    map_grid((size(map_grid)-wide1):size(map_grid),k) = TTL;
    if mod(k,100) == 0
        TTL = rand;
    end
end
TTI = 1; % 西
for k = mapLen_y-area_div(4)+1:area_div(4)
    map_grid(k,1:wide1) = TTL;
    if mod(k,100) == 0
        TTL = rand;
    end
end
TTI = 1; % 东
for k = mapLen_y-area_div(4)+1:area_div(4)
    map_grid(k,(size(map_grid)-wide1:size(map_grid))) = TTL;
    if mod(k,100) == 0
        TTL = rand;
    end
end
% 画出四环的坐标
TTI = 1; % 北
for k = mapLen_y-area_div(3)+1:area_div(3)
    map_grid(1:wide1,k) = TTL;
    if mod(k,100) == 0
        TTL = rand;
    end
end
TTI = 1; % 南
for k = mapLen_y-area_div(3)+1:area_div(3)
    map_grid((size(map_grid)-wide1):size(map_grid),k) = TTL;
    if mod(k,100) == 0
        TTL = rand;
    end
end
TTI = ; % 西
for k = mapLen_y-area_div(3)+1:area_div(3)
    map_grid(k,1:wide1) = TTL;
    if mod(k,100) == 0
        TTL = rand;
    end
end
TTI = 1; % 东
for k = mapLen_y-area_div(3)+1:area_div(3)
    map_grid(k,(size(map_grid)-wide1:size(map_grid))) = TTL;
    if mod(k,100) == 0
        TTL = rand;
    end
end
% 画出三环的坐标
TTI = 1; % 北
for k = mapLen_y-area_div(2)+1:area_div(2)
    map_grid(1:wide1,k) = TTL;
    if mod(k,100) == 0
        TTL = rand;
    end
end
TTI = 1; % 南
for k = mapLen_y-area_div(2)+1:area_div(2)
    map_grid((size(map_grid)-wide1):size(map_grid),k) = TTL;
    if mod(k,100) == 0
        TTL = rand;
    end
end
TTI = ; % 西
for k = mapLen_y-area_div(2)+1:area_div(2)
    map_grid(k,1:wide1) = TTL;
    if mod(k,100) == 0
        TTL = rand;
    end
end
TTI = 1; % 东
for k = mapLen_y-area_div(2)+1:area_div(2)
    map_grid(k,(size(map_grid)-wide1:size(map_grid))) = TTL;
    if mod(k,100) == 0
        TTL = rand;
    end
end
% 画出二环的坐标
TTI = 1; % 北
for k = mapLen_y-area_div(1)+1:area_div(1)
    map_grid(1:wide1,k) = TTL;
    if mod(k,100) == 0
        TTL = rand;
    end
end
TTI = 1; % 南
for k = mapLen_y-area_div(1)+1:area_div(1)
    map_grid((size(map_grid)-wide1):size(map_grid),k) = TTL;
    if mod(k,100) == 0
        TTL = rand;
    end
end
TTI = ; % 西
for k = mapLen_y-area_div(1)+1:area_div(1)
    map_grid(k,1:wide1) = TTL;
    if mod(k,100) == 0
        TTL = rand;
    end
end
TTI = 1; % 东
for k = mapLen_y-area_div(1)+1:area_div(1)
    map_grid(k,(size(map_grid)-wide1:size(map_grid))) = TTL;
    if mod(k,100) == 0
        TTL = rand;
    end
end
