clear
clc

data_cleanRange = 3;

red1 = xlsread('data1.xlsx', 'red1', 'B3:K29');
white1 = xlsread('data1.xlsx', 'white1', 'B3:K30');
red2 = xlsread('data1.xlsx', 'red2', 'B3:K29');
white2 = xlsread('data1.xlsx', 'white2', 'B3:K30');

figure('Name','data1-red1')
for k = 1:size(red1,2)
    subplot(2,5,k)
    x = 1:size(red1,1);
    y = red1(:,k);
    plot(x,y,'*')
    hold on
    x = 1:size(red1,1);
    y = repelem(mean(red1(:,k)),numel(x));
    plot(x,y)
    x = 1:size(red1,1);
    y = repelem((mean(red1(:,k))-data_cleanRange*std(red1(:,k))),numel(x));
    plot(x,y,'--')
    y = repelem((mean(red1(:,k))+data_cleanRange*std(red1(:,k))),numel(x));
    plot(x,y,'--')
    title(sprintf('factor%d', k))
    ylabel('score')
    for m = 1:size(red1,1)
        if red1(m,k)>(mean(red1(:,k))+data_cleanRange*std(red1(:,k))) | red1(m,k)<(mean(red1(:,k))-data_cleanRange*std(red1(:,k)))
            red1(m,k) = 0;
        end
    end
    legend('得分散点','均值','上限','下限')
end

figure('Name','data1-white1')
for k = 1:size(white1,2)
    subplot(2,5,k)
    x = 1:size(white1,1);
    y = white1(:,k);
    plot(x,y,'*')
    hold on
    x = 1:size(white1,1);
    y = repelem(mean(white1(:,k)),numel(x));
    plot(x,y)
    x = 1:size(white1,1);
    y = repelem((mean(white1(:,k))-data_cleanRange*std(white1(:,k))),numel(x));
    plot(x,y,'--')
    y = repelem((mean(white1(:,k))+data_cleanRange*std(white1(:,k))),numel(x));
    plot(x,y,'--')
    title(sprintf('factor%d', k))
    ylabel('score')
    for m = 1:size(white1,1)
        if white1(m,k)>(mean(white1(:,k))+data_cleanRange*std(white1(:,k))) | white1(m,k)<(mean(white1(:,k))-data_cleanRange*std(white1(:,k)))
            white1(m,k) = 0;
        end
    end
    legend('得分散点','均值','上限','下限')
end

figure('Name','data1-red2')
for k = 1:size(red2,2)
    subplot(2,5,k)
    x = 1:size(red2,1);
    y = red2(:,k);
    plot(x,y,'*')
    hold on
    x = 1:size(red2,1);
    y = repelem(mean(red2(:,k)),numel(x));
    plot(x,y)
    x = 1:size(red2,1);
    y = repelem((mean(red2(:,k))-data_cleanRange*std(red2(:,k))),numel(x));
    plot(x,y,'--')
    y = repelem((mean(red2(:,k))+data_cleanRange*std(red2(:,k))),numel(x));
    plot(x,y,'--')
    title(sprintf('factor%d', k))
    ylabel('score')
    for m = 1:size(red2,1)
        if red2(m,k)>(mean(red2(:,k))+data_cleanRange*std(red2(:,k))) | red2(m,k)<(mean(red2(:,k))-data_cleanRange*std(red2(:,k)))
            red2(m,k) = 0;
        end
    end
    legend('得分散点','均值','上限','下限')
end

figure('Name','data1-white2')
for k = 1:size(white2,2)
    subplot(2,5,k)
    x = 1:size(white2,1);
    y = white2(:,k);
    plot(x,y,'*')
    hold on
    x = 1:size(white2,1);
    y = repelem(mean(white2(:,k)),numel(x));
    plot(x,y)
    x = 1:size(white2,1);
    y = repelem((mean(white2(:,k))-data_cleanRange*std(white2(:,k))),numel(x));
    plot(x,y,'--')
    y = repelem((mean(white2(:,k))+data_cleanRange*std(white2(:,k))),numel(x));
    plot(x,y,'--')
    title(sprintf('factor%d', k))
    ylabel('score')
    for m = 1:size(white2,1)
        if white2(m,k)>(mean(white2(:,k))+data_cleanRange*std(white2(:,k))) | white2(m,k)<(mean(white2(:,k))-data_cleanRange*std(white2(:,k)))
            white2(m,k) = 0;
        end
    end
    legend('得分散点','均值','上限','下限')
end

figure('Name','demo')
subplot(1,2,1)
x = 1:size(white2,1);
y = white2(:,9);
plot(x,y,'-*')
hold on
x = 1:size(white2,1);
y = repelem(mean(white2(:,9)),numel(x));
plot(x,y)
x = 1:size(white2,1);
y = repelem((mean(white2(:,9))-data_cleanRange*std(white2(:,9))),numel(x));
plot(x,y,'--')
y = repelem((mean(white2(:,9))+data_cleanRange*std(white2(:,9))),numel(x));
plot(x,y,'--')
title('白酒第二组口感分析质量得分散点图')
ylabel('score')
legend('得分散点','均值','上限','下限')
subplot(1,2,2)
x = 1:size(white1,1);
y = white1(:,8);
plot(x,y,'-*')
hold on
x = 1:size(white1,1);
y = repelem(mean(white1(:,8)),numel(x));
plot(x,y)
x = 1:size(white1,1);
y = repelem((mean(white1(:,8))-data_cleanRange*std(white1(:,8))),numel(x));
plot(x,y,'--')
y = repelem((mean(white1(:,8))+data_cleanRange*std(white1(:,8))),numel(x));
plot(x,y,'--')
title('白酒第一组口感分析持久性得分散点图')
ylabel('score')
legend('得分散点','均值','上限','下限')

disp('red1-2');
for k = 1:size(red1,2)
    n = 1;
    for m = 1:size(red1,1)
        if red1(m,k) ~= 0
            red1_col(n) = red1(m,k);
            n = n+1;
        end
    end
    n = 1;
    for m = 1:size(red2,1)
        if red2(m,k) ~= 0
            red2_col(n) = red2(m,k);
            n = n+1;
        end
    end
    std_red1col = std(red1_col);
    std_red2col = std(red2_col);
    freedom = (std_red1col^2/numel(red1_col)+std_red2col^2/numel(red2_col))^2 / ((std_red1col^2/numel(red1_col))^2/(numel(red1_col)-1)+(std_red2col^2/numel(red2_col))^2/(numel(red2_col)-1));
    t = (mean(red1_col)-mean(red2_col))/sqrt(std_red1col^2/numel(red1_col)+std_red2col^2/numel(red2_col));
    disp([freedom t]);
end

disp('white1-2');
for k = 1:size(white1,2)
    n = 1;
    for m = 1:size(white1,1)
        if white1(m,k) ~= 0
            white1_col(n) = white1(m,k);
            n = n+1;
        end
    end
    n = 1;
    for m = 1:size(white2,1)
        if white2(m,k) ~= 0
            white2_col(n) = white2(m,k);
            n = n+1;
        end
    end
    std_white1col = std(white1_col);
    std_white2col = std(white2_col);
    freedom = (std_white1col^2/numel(white1_col)+std_white2col^2/numel(white2_col))^2 / ((std_white1col^2/numel(white1_col))^2/(numel(white1_col)-1)+(std_white2col^2/numel(white2_col))^2/(numel(white2_col)-1));
    t = (mean(white1_col)-mean(white2_col))/sqrt(std_white1col^2/numel(white1_col)+std_white2col^2/numel(white2_col));
    disp([freedom t]);
end

xlswrite('output1.xlsx', red1, 'red1', 'A1');
xlswrite('output1.xlsx', white1, 'white1', 'A1');
xlswrite('output1.xlsx', red2, 'red2', 'A1');
xlswrite('output1.xlsx', white2, 'white2', 'A1');
