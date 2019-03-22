A_mainRoad = xlsread('data2.xls', 'ȫ��������ڵ�λ��', 'C2:C14');
A_area = xlsread('data2.xls', 'ȫ�н�ͨ·�ڽڵ�����', 'B2:C93');
A_road = xlsread('data2.xls', 'ȫ�н�ͨ·�ڵ�·��', 'A2:B141');

graph_mat = zeros(size(A_area,1));
for k = 1:size(A_road,1)
    graph_mat(A_road(k,1),A_road(k,2)) = sqrt((A_area(A_road(k,1),1)-A_area(A_road(k,2),1))^2+(A_area(A_road(k,1),2)-A_area(A_road(k,2),2))^2);
    graph_mat(A_road(k,2),A_road(k,1)) = sqrt((A_area(A_road(k,1),1)-A_area(A_road(k,2),1))^2+(A_area(A_road(k,1),2)-A_area(A_road(k,2),2))^2);
end

road_net = graph(graph_mat);
shortest_road_mat = distances(road_net);
xlswrite('output1_2.xlsx', shortest_road_mat, 'shortest_road_mat', 'A1');
