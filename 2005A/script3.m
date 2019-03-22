clear
clc

%设置全局变量[year_num3 x_num]
year_num3 = 10;
grade_num = 6;
N = 4
foreYear_num = 10;

%导入数据[report]
report = zeros(9,13,10);
for k = 1:10
    num = xlsread('data.xlsx', 3, join(['C' sprintf('%d',6+(k-1)*14) ':O' sprintf('%d',14+(k-1)*14)]));
    report(:,:,k) = num;
end


%---------------------枯水期全流域---------------------%
%整理本次用到的数据[lg_mat]
lg_mat = zeros(year_num3, grade_num);
for m = 1:year_num3
    for n = 1:grade_num
        lg_mat(m,n) = report(1, (2+2*(n-1)), m);
    end
end

%单个类别对总污染物的时间序列可视化
figure('Name','枯水期全流域')
for k = 1:grade_num
    subplot(3,2,k)
    xi = 1:year_num3;
    yi = lg_mat(:,k);
    plot(xi, yi, '--')
    xlabel('时间/年')
    ylabel(join([sprintf('%d',k) '类水质的枯水期全流域河长/km']))
    title(join([sprintf('%d',k) '类水质污染物的时间序列图']))
end

%趋势性移动平均法
lg_mat1 = zeros(year_num3-N+1, grade_num);
lg_mat2 = zeros(year_num3-2*N+1, grade_num);
for k = 1:size(lg_mat1,1)
    lg_mat1(k,:) = mean(lg_mat(k:k+N-1,:));
end
for k = 1:size(lg_mat2,1)
    lg_mat2(k,:) = mean(lg_mat1(k:k+N-1,:));
end
a = 2.*lg_mat1(size(lg_mat1,1),:)-lg_mat2(size(lg_mat2,1),:)
b = 2/(N-1).*(lg_mat1(size(lg_mat1,1),:)-lg_mat2(size(lg_mat2,1),:))
fore_result = zeros(foreYear_num, grade_num);
for k = 1:foreYear_num
    fore_result(k,:) = a + b.*k;
end
fore1_1 = fore_result;


%---------------------枯水期干流---------------------%
%整理本次用到的数据[lg_mat]
lg_mat = zeros(year_num3, grade_num);
for m = 1:year_num3
    for n = 1:grade_num
        lg_mat(m,n) = report(2, (2+2*(n-1)), m);
    end
end

%单个类别对总污染物的时间序列可视化
figure('Name','枯水期干流')
for k = 1:grade_num
    subplot(3,2,k)
    xi = 1:year_num3;
    yi = lg_mat(:,k);
    plot(xi, yi, '--')
    xlabel('时间/年')
    ylabel(join([sprintf('%d',k) '类水质的枯水期干流河长/km']))
    title(join([sprintf('%d',k) '类水质污染物的时间序列图']))
end

%趋势性移动平均法
lg_mat1 = zeros(year_num3-N, grade_num);
lg_mat2 = zeros(year_num3-2*N, grade_num);
for k = 1:size(lg_mat1,1)
    lg_mat1(k,:) = mean(lg_mat(k:k+N-1,:));
end
for k = 1:size(lg_mat2,1)
    lg_mat2(k,:) = mean(lg_mat1(k:k+N-1,:));
end
a = 2.*lg_mat1(size(lg_mat1,1),:)-lg_mat2(size(lg_mat2,1),:)
b = 2/(N-1).*(lg_mat1(size(lg_mat1,1),:)-lg_mat2(size(lg_mat2,1),:))
fore_result = zeros(foreYear_num, grade_num);
for k = 1:foreYear_num
    fore_result(k,:) = a + b.*k;
end
fore1_2 = fore_result;


%---------------------枯水期支流--------------------%
%整理本次用到的数据[lg_mat]
lg_mat = zeros(year_num3, grade_num);
for m = 1:year_num3
    for n = 1:grade_num
        lg_mat(m,n) = report(3, (2+2*(n-1)), m);
    end
end

%单个类别对总污染物的时间序列可视化
figure('Name','枯水期支流')
for k = 1:grade_num
    subplot(3,2,k)
    xi = 1:year_num3;
    yi = lg_mat(:,k);
    plot(xi, yi, '--')
    xlabel('时间/年')
    ylabel(join([sprintf('%d',k) '类水质的枯水期支流河长/km']))
    title(join([sprintf('%d',k) '类水质污染物的时间序列图']))
end

%趋势性移动平均法
lg_mat1 = zeros(year_num3-N, grade_num);
lg_mat2 = zeros(year_num3-2*N, grade_num);
for k = 1:size(lg_mat1,1)
    lg_mat1(k,:) = mean(lg_mat(k:k+N-1,:));
end
for k = 1:size(lg_mat2,1)
    lg_mat2(k,:) = mean(lg_mat1(k:k+N-1,:));
end
a = 2.*lg_mat1(size(lg_mat1,1),:)-lg_mat2(size(lg_mat2,1),:)
b = 2/(N-1).*(lg_mat1(size(lg_mat1,1),:)-lg_mat2(size(lg_mat2,1),:))
fore_result = zeros(foreYear_num, grade_num);
for k = 1:foreYear_num
    fore_result(k,:) = a + b.*k;
end
fore1_3 = fore_result;


%---------------------丰水期全流域---------------------%
%整理本次用到的数据[lg_mat]
lg_mat = zeros(year_num3, grade_num);
for m = 1:year_num3
    for n = 1:grade_num
        lg_mat(m,n) = report(4, (2+2*(n-1)), m);
    end
end

%单个类别对总污染物的时间序列可视化
figure('Name','丰水期全流域')
for k = 1:grade_num
    subplot(3,2,k)
    xi = 1:year_num3;
    yi = lg_mat(:,k);
    plot(xi, yi, '--')
    xlabel('时间/年')
    ylabel(join([sprintf('%d',k) '类水质的丰水期全流域河长/km']))
    title(join([sprintf('%d',k) '类水质污染物的时间序列图']))
end

%趋势性移动平均法
lg_mat1 = zeros(year_num3-N, grade_num);
lg_mat2 = zeros(year_num3-2*N, grade_num);
for k = 1:size(lg_mat1,1)
    lg_mat1(k,:) = mean(lg_mat(k:k+N-1,:));
end
for k = 1:size(lg_mat2,1)
    lg_mat2(k,:) = mean(lg_mat1(k:k+N-1,:));
end
a = 2.*lg_mat1(size(lg_mat1,1),:)-lg_mat2(size(lg_mat2,1),:)
b = 2/(N-1).*(lg_mat1(size(lg_mat1,1),:)-lg_mat2(size(lg_mat2,1),:))
fore_result = zeros(foreYear_num, grade_num);
for k = 1:foreYear_num
    fore_result(k,:) = a + b.*k;
end
fore2_1 = fore_result;


%---------------------丰水期干流---------------------%
%整理本次用到的数据[lg_mat]
lg_mat = zeros(year_num3, grade_num);
for m = 1:year_num3
    for n = 1:grade_num
        lg_mat(m,n) = report(5, (2+2*(n-1)), m);
    end
end

%单个类别对总污染物的时间序列可视化
figure('Name','丰水期干流')
for k = 1:grade_num
    subplot(3,2,k)
    xi = 1:year_num3;
    yi = lg_mat(:,k);
    plot(xi, yi, '--')
    xlabel('时间/年')
    ylabel(join([sprintf('%d',k) '类水质的丰水期干流河长/km']))
    title(join([sprintf('%d',k) '类水质污染物的时间序列图']))
end

%趋势性移动平均法
lg_mat1 = zeros(year_num3-N, grade_num);
lg_mat2 = zeros(year_num3-2*N, grade_num);
for k = 1:size(lg_mat1,1)
    lg_mat1(k,:) = mean(lg_mat(k:k+N-1,:));
end
for k = 1:size(lg_mat2,1)
    lg_mat2(k,:) = mean(lg_mat1(k:k+N-1,:));
end
a = 2.*lg_mat1(size(lg_mat1,1),:)-lg_mat2(size(lg_mat2,1),:)
b = 2/(N-1).*(lg_mat1(size(lg_mat1,1),:)-lg_mat2(size(lg_mat2,1),:))
fore_result = zeros(foreYear_num, grade_num);
for k = 1:foreYear_num
    fore_result(k,:) = a + b.*k;
end
fore2_2 = fore_result;


%---------------------丰水期支流---------------------%
%整理本次用到的数据[lg_mat]
lg_mat = zeros(year_num3, grade_num);
for m = 1:year_num3
    for n = 1:grade_num
        lg_mat(m,n) = report(6, (2+2*(n-1)), m);
    end
end

%单个类别对总污染物的时间序列可视化
figure('Name','丰水期支流')
for k = 1:grade_num
    subplot(3,2,k)
    xi = 1:year_num3;
    yi = lg_mat(:,k);
    plot(xi, yi, '--')
    xlabel('时间/年')
    ylabel(join([sprintf('%d',k) '类水质的丰水期支流河长/km']))
    title(join([sprintf('%d',k) '类水质污染物的时间序列图']))
end

%趋势性移动平均法
lg_mat1 = zeros(year_num3-N, grade_num);
lg_mat2 = zeros(year_num3-2*N, grade_num);
for k = 1:size(lg_mat1,1)
    lg_mat1(k,:) = mean(lg_mat(k:k+N-1,:));
end
for k = 1:size(lg_mat2,1)
    lg_mat2(k,:) = mean(lg_mat1(k:k+N-1,:));
end
a = 2.*lg_mat1(size(lg_mat1,1),:)-lg_mat2(size(lg_mat2,1),:)
b = 2/(N-1).*(lg_mat1(size(lg_mat1,1),:)-lg_mat2(size(lg_mat2,1),:))
fore_result = zeros(foreYear_num, grade_num);
for k = 1:foreYear_num
    fore_result(k,:) = a + b.*k;
end
fore2_3 = fore_result;


%---------------------水文年全流域---------------------%
%整理本次用到的数据[lg_mat]
lg_mat = zeros(year_num3, grade_num);
for m = 1:year_num3
    for n = 1:grade_num
        lg_mat(m,n) = report(7, (2+2*(n-1)), m);
    end
end

%单个类别对总污染物的时间序列可视化
figure('Name','水文年全流域')
for k = 1:grade_num
    subplot(3,2,k)
    xi = 1:year_num3;
    yi = lg_mat(:,k);
    plot(xi, yi, '--')
    xlabel('时间/年')
    ylabel(join([sprintf('%d',k) '类水质的水文年全流域河长/km']))
    title(join([sprintf('%d',k) '类水质污染物的时间序列图']))
end

%趋势性移动平均法
lg_mat1 = zeros(year_num3-N, grade_num);
lg_mat2 = zeros(year_num3-2*N, grade_num);
for k = 1:size(lg_mat1,1)
    lg_mat1(k,:) = mean(lg_mat(k:k+N-1,:));
end
for k = 1:size(lg_mat2,1)
    lg_mat2(k,:) = mean(lg_mat1(k:k+N-1,:));
end
a = 2.*lg_mat1(size(lg_mat1,1),:)-lg_mat2(size(lg_mat2,1),:)
b = 2/(N-1).*(lg_mat1(size(lg_mat1,1),:)-lg_mat2(size(lg_mat2,1),:))
fore_result = zeros(foreYear_num, grade_num);
for k = 1:foreYear_num
    fore_result(k,:) = a + b.*k;
end
fore3_1 = fore_result;


%---------------------水文年干流---------------------%
%整理本次用到的数据[lg_mat]
lg_mat = zeros(year_num3, grade_num);
for m = 1:year_num3
    for n = 1:grade_num
        lg_mat(m,n) = report(8, (2+2*(n-1)), m);
    end
end

%单个类别对总污染物的时间序列可视化
figure('Name','水文年干流')
for k = 1:grade_num
    subplot(3,2,k)
    xi = 1:year_num3;
    yi = lg_mat(:,k);
    plot(xi, yi, '--')
    xlabel('时间/年')
    ylabel(join([sprintf('%d',k) '类水质的水文年干流河长/km']))
    title(join([sprintf('%d',k) '类水质污染物的时间序列图']))
end

%趋势性移动平均法
lg_mat1 = zeros(year_num3-N, grade_num);
lg_mat2 = zeros(year_num3-2*N, grade_num);
for k = 1:size(lg_mat1,1)
    lg_mat1(k,:) = mean(lg_mat(k:k+N-1,:));
end
for k = 1:size(lg_mat2,1)
    lg_mat2(k,:) = mean(lg_mat1(k:k+N-1,:));
end
a = 2.*lg_mat1(size(lg_mat1,1),:)-lg_mat2(size(lg_mat2,1),:)
b = 2/(N-1).*(lg_mat1(size(lg_mat1,1),:)-lg_mat2(size(lg_mat2,1),:))
fore_result = zeros(foreYear_num, grade_num);
for k = 1:foreYear_num
    fore_result(k,:) = a + b.*k;
end
fore3_2 = fore_result;


%---------------------水文年支流---------------------%
%整理本次用到的数据[lg_mat]
lg_mat = zeros(year_num3, grade_num);
for m = 1:year_num3
    for n = 1:grade_num
        lg_mat(m,n) = report(9, (2+2*(n-1)), m);
    end
end

%单个类别对总污染物的时间序列可视化
figure('Name','水文年支流')
for k = 1:grade_num
    subplot(3,2,k)
    xi = 1:year_num3;
    yi = lg_mat(:,k);
    plot(xi, yi, '--')
    xlabel('时间/年')
    ylabel(join([sprintf('%d',k) '类水质的水文年支流河长/km']))
    title(join([sprintf('%d',k) '类水质污染物的时间序列图']))
end

%趋势性移动平均法
lg_mat1 = zeros(year_num3-N, grade_num);
lg_mat2 = zeros(year_num3-2*N, grade_num);
for k = 1:size(lg_mat1,1)
    lg_mat1(k,:) = mean(lg_mat(k:k+N-1,:));
end
for k = 1:size(lg_mat2,1)
    lg_mat2(k,:) = mean(lg_mat1(k:k+N-1,:));
end
a = 2.*lg_mat1(size(lg_mat1,1),:)-lg_mat2(size(lg_mat2,1),:)
b = 2/(N-1).*(lg_mat1(size(lg_mat1,1),:)-lg_mat2(size(lg_mat2,1),:))
fore_result = zeros(foreYear_num, grade_num);
for k = 1:foreYear_num
    fore_result(k,:) = a + b.*k;
end
fore3_3 = fore_result;


xlswrite('data.xlsx', [fore1_1; fore1_2; fore1_3; fore2_1; fore2_2; fore2_3; fore3_1; fore3_2; fore3_3], 4, '   B1');
