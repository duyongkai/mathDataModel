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
        if min_dist<=30
            plot_x(count) = map_x(m);
            plot_y(count) = map_y(n);
            plot_police(count) = min_place(1);
            count = count+1;
        end
    end
end

