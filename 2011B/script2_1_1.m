clear

x_limit = [0 500];
y_limit = [0 600];

areas = xlsread('data.xls', '全市交通路口节点数据', 'B2:C583');
polices = xlsread('data.xls', '全市交巡警平台', 'B2:B81');

police_points = areas(polices,:);
map_x = x_limit(1):x_limit(2);
map_y = y_limit(1):y_limit(2);

count = 1;
for m = 1:numel(map_x)
    for n = 1:numel(map_y)
        for k = 1:size(police_points,1)
            distance_list(k) = sqrt((map_x(m)-police_points(k,1))^2+(map_y(n)-police_points(k,2))^2);
        end
        min_dist = min(distance_list);
        min_place = find(distance_list==min_dist);
        plot_x(count) = map_x(m);
        plot_y(count) = map_y(n);
        plot_police(count) = min_place(1);
        count = count+1;
    end
end
for k = 1:count-1
    plot([plot_x(k) police_points(plot_police(k),1)], [plot_y(k) police_points(plot_police(k),2)], 'y')
    hold on
end
plot(areas(:,1),areas(:,2),'r*')
for k = 1:size(polices,1)
    plot(areas(polices(k),1),areas(polices(k),2),'ko')
end
for k = 1:size(areas,1)
    text(areas(k,1),areas(k,2),sprintf('%d',k))
end
hold off
