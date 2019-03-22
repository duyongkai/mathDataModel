clear

A_area = xlsread('data1_3.xlsx', 1, 'C2:D93');
A_case = xlsread('data1_3.xlsx', 1, 'F2:F93');
police_num = 25;

for n = [police_num:49 51:65 67:83 85:92]
    police_points = A_area([1:21 50 66 84 n],:);
    mapA_x = A_area(:,1);
    mapA_y = A_area(:,2);

    count = 1;
    for m = 1:numel(mapA_x)
        for k = 1:police_num
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
    for k = 1:police_num
        case_sumNum(k) = sum(A_case(find(min_police==k)));
    end
    vary_rate(n) = std(case_sumNum)/mean(case_sumNum);
end

xlswrite('output1_3.xlsx', vary_rate, sprintf('%d',police_num), 'A2');






% A_area = xlsread('data1_3.xlsx', 1, 'C2:D93');
% A_case = xlsread('data1_3.xlsx', 1, 'F2:F93');
% police_num = 22;

% police_points = A_area(1:police_num,:);
% mapA_x = A_area(:,1);
% mapA_y = A_area(:,2);
% vary_rate = zeros(1,92);
% for n = police_num+1:92
%     count = 1;
%     for m = 1:numel(mapA_x)
%         for k = 1:police_num
%             distance_list(k) = sqrt((mapA_x(m)-police_points(k,1))^2+(mapA_y(m)-police_points(k,2))^2);
%         end
%         min_dist = min(distance_list);
%         min_place = find(distance_list==min_dist);
%         if min_dist <= 30
%             plot_x(count) = mapA_x(m);
%             plot_y(count) = mapA_y(m);
%             min_police(count) = min_place(1);
%             count = count+1;
%         end
%     end
%     for k = 1:police_num
%         case_sumNum(k) = sum(A_case(find(min_police==k)));
%     end
%     vary_rate(n) = std(case_sumNum)/mean(case_sumNum);
% end

% [find(vary_rate==min(vary_rate)) min(vary_rate)]
% xlswrite('output1_3.xlsx', [1:police_num;case_sumNum], sprintf('%d',police_num), 'A1');



% plot(plot_x, plot_y, 'y*')
% hold on
% for k = 1:size(min_police,2)
%     plot([plot_x(k) police_points(min_police(k),1)], [plot_y(k) police_points(min_police(k),2)])
% end
% hold off
