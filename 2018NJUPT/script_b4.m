clear;
clc;

%����ԭʼ����-[sourceData4]
sourceData4 = xlsread('E:\Users\dyk\Documents\Projects\��ѧ��ģ\��ģУ��\У����Ŀ\B�⸽��.xlsx', '����4-��ȡ��ÿ������=���-ȡ��', 'A1:AD365');

%���ݿ��ӻ�������30��ʡ��365����ֵ��ɢ��ͼ
for k = 1:30
    subplot(15, 2, k)
    x = sort(sourceData4(:, k));
    y = repelem(0, 365);
    plot(x, y, '*r');
end
clearvars x y k;

%���ݵ�������30��ʡ��365����ֵ��ƽ��ֵ�ͱ�׼��-[mean_zones std_zones]
for k = 1:30
    mean_zones(k) = mean(sourceData4(:,k));
    std_zones(k) = std(sourceData4(:,k));
end
clearvars k;

%�����������30��ʡ�Ĳ�ֵ��ƽ��ֵ��ƽ��ֵ�ͱ�׼��-[mean_total std_total]
mean_total = mean(mean_zones);
std_total = std(mean_zones);

%��ʾ�������
disp('## ԭʼ���ݵ����屨��');
disp('- 30��ʡ��365����ֵ��ƽ��ֵ�ͱ�׼��-[mean_zones std_zones]');
disp([transpose(mean_zones) transpose(std_zones)]);
disp('- 30��ʡ�Ĳ�ֵ��ƽ��ֵ��ƽ��ֵ�ͱ�׼��-[mean_total std_total]');
disp([mean_total std_total]);

%����2017�����ʡ�ı����ʽ�
for m = 1:30
    sum_temp = 0;
    for k = 1:365
        sum_temp = sum_temp + sourceData4(k,m);
        sum_data(k) = sum_temp;
    end
    result2017(m) = -1 * min(sum_data);
end

%�������ɷ��ϸ����ܶȵ�������ĸ�����-[N]
N = 100000;

%ͨ�������ģ��ķ������������ʡ����99%����µı����ʽ�
for c = 1:30
    for n = 1:N
        %��һ�������ڣ�����һ��365��������
        for k = 1:365
            data_zone(k) = randn * std_zones(c);
        end
        %��365�������������ۼ����
        sum_temp = 0;
        for k = 1:365
            sum_temp = sum_temp + data_zone(k);
            sum_data(k) = sum_temp;
        end
        result(n) = min(sum_data);
    end
    result_zones(c) = -1 * max(mink(result, round(N*0.1)));
    mean_result(c) = -1 * mean(result);
    std_result(c) = std(result);
end

%��ʾ�������
disp('## ģ�����ݷ�������');
disp('- ģ������ݸ���N');
disp(N);
disp('- 2017��30��ʡ���Եı����ʽ���2018��30��ʡ��99%����ˮƽ�¸��Եı����ʽ�ģ��ֵ��������ģ��ֵ�ı�׼��');
disp(['result2017' ' ' 'result_zones' ' ' 'mean_result' ' ' 'std_result']);
disp([transpose(result2017) transpose(result_zones) transpose(mean_result) transpose(std_result)]);
xlswrite('report.xlsx', [transpose(result2017) transpose(mean_result) transpose(std_result)], 4, 'A2');
