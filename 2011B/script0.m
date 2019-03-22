A_area = xlsread('data.xls', '全市交通路口节点数据', 'B2:C93');
A_P = xlsread('data.xls', '全市交通路口节点数据', 'E2:E93');
A_road = xlsread('data.xls', '全市交通路口的路线', 'A2:B93');
B_area = xlsread('data.xls', '全市交通路口节点数据', 'B94:C166');
B_P = xlsread('data.xls', '全市交通路口节点数据', 'E94:E166');
B_road = xlsread('data.xls', '全市交通路口的路线', 'A94:B166');
C_area = xlsread('data.xls', '全市交通路口节点数据', 'B167:C320');
C_P = xlsread('data.xls', '全市交通路口节点数据', 'E167:E320');
C_road = xlsread('data.xls', '全市交通路口的路线', 'A167:B320');
D_area = xlsread('data.xls', '全市交通路口节点数据', 'B321:C372');
D_P = xlsread('data.xls', '全市交通路口节点数据', 'E321:E372');
D_road = xlsread('data.xls', '全市交通路口的路线', 'A321:B372');
E_area = xlsread('data.xls', '全市交通路口节点数据', 'B373:C475');
E_P = xlsread('data.xls', '全市交通路口节点数据', 'E373:E475');
E_road = xlsread('data.xls', '全市交通路口的路线', 'A373:B475');
F_area = xlsread('data.xls', '全市交通路口节点数据', 'B476:C583');
F_P = xlsread('data.xls', '全市交通路口节点数据', 'E476:E583');
F_road = xlsread('data.xls', '全市交通路口的路线', 'A476:B583');

areas =[A_area; B_area; C_area; D_area; E_area; F_area];
P = [A_P; B_P; C_P; D_P; E_P; F_P];
road = [A_road; B_road; C_road; D_road; E_road; F_road];

figure('Name', '交通物理网络图')
plot(A_area(:,1), A_area(:,2), 'r*')
hold on
plot(B_area(:,1), B_area(:,2), 'y*')
plot(C_area(:,1), C_area(:,2), 'g*')
plot(D_area(:,1), D_area(:,2), 'b*')
plot(E_area(:,1), E_area(:,2), 'k*')
plot(F_area(:,1), F_area(:,2), 'm*')
for k = 1:size(A_area,1)
    plot([areas(A_road(k,1),1) areas(A_road(k,2),1)], [areas(A_road(k,1),2) areas(A_road(k,2),2)])
end
hold off

road_net_A = zeros(size(areas,1));
for k = 1:size(areas,1)
    road_net_A(road(k,1), road(k,2)) = 1;
    road_net_A(road(k,2), road(k,1)) = 1;
end
% point_name = {};
% id = 1:size(areas, 1);
% for k = 1:size(areas,1)
%     point_name(k) = {sprintf('%d-%d',id(k),P(k))};
% end
road_network_A = graph(road_net_A);
figure('Name', '交通逻辑网络图')
plot(road_network_A)
