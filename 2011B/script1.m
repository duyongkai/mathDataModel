A_area = xlsread('data.xls', '全市交通路口节点数据', 'B2:C93');

police_points = A_area(1:20,:);
mapA_x = A_area(21:size(A_area,1),1);
mapA_y = A_area(21:size(A_area,1),2);

count = 1;
for m = 1:numel(mapA_x)
    for k = 1:20
        distance_list(k) = sqrt((mapA_x(m)-police_points(k,1))^2+(mapA_y(m)-police_points(k,2))^2);
    end
    min_dist = min(distance_list);
    min_place = find(distance_list==min_dist);
    if min_dist <= 30
        plot_x(count) = mapA_x(m);
        plot_y(count) = mapA_y(m);
        min_police(count) = min_place(1);
        count = count+1;
    end
end
plot(A_area(:,1), A_area(:,2), '*')
for k = 1:size(A_area,1)
    text(A_area(k,1), A_area(k,2), sprintf('%d', k))
end
hold on
for k = 1:size(min_police,2)
    plot([plot_x(k) police_points(min_police(k),1)], [plot_y(k) police_points(min_police(k),2)])
end
hold off
