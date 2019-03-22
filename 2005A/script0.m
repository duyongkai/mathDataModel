clear
clc

%��������-[factors grades flow_l flow_v report name1 name2]
factors = zeros(17,5,28);
% grades = cell(17,1,28);
flow_l = zeros(13,7);
flow_v = zeros(13,7);
report = zeros(9,13,10);
for k = 1:28
    num = xlsread('data.xlsx', 1, join(['D' sprintf('%d',7+21*(k-1)) ':H' sprintf('%d',23+21*(k-1))]));
    factors(:,:,k) = num;
end
for k = 1:13
    num = xlsread('data.xlsx', 2, join(['C' sprintf('%d',5+(k-1)*2) ':I' sprintf('%d',5+(k-1)*2)]));
    flow_l(k,:) = num;
end
for k = 1:13
    num = xlsread('data.xlsx', 2, join(['C' sprintf('%d',6+(k-1)*2) ':I' sprintf('%d',6+(k-1)*2)]));
    flow_v(k,:) = num;
end
for k = 1:10
    num = xlsread('data.xlsx', 3, join(['C' sprintf('%d',6+(k-1)*14) ':O' sprintf('%d',14+(k-1)*14)]));
    report(:,:,k) = num;
end
[num name1] = xlsread('data.xlsx', 1, 'B7:B23');
[num name2] = xlsread('data.xlsx', 2, 'C3:I3');
clearvars k num txt;

%���ݿ��ӻ�-CODMn-[mean3 std3]
figure
hold on
disp('# ���������ڸ��۲�����ʷ���ݵľ�ֵ�ͱ�׼��');
disp(['     ��ֵ     ' '��׼��'])
for x = 1:17
    for k = 1:28
        y(k) = factors(x,3,k);
    end
    mean3(x) = mean(y);
    std3(x) = std(y);
    plot(repelem(x,28),y,'*');
end
disp(['     ��ֵ     ' '��׼��'])
disp([transpose(mean3) transpose(std3)])
plot(1:17,mean3);
plot(1:17,std3,'-.');
plot(1:0.1:17,repelem(2,161),'--')
plot(1:0.1:17,repelem(4,161),'--')
plot(1:0.1:17,repelem(6,161),'--')
plot(1:0.1:17,repelem(10,161),'--')
plot(1:0.1:17,repelem(15,161),'--')
hold off
xlabel('���б��');
ylabel('ָ����ֵ');
title('���������ڸ��۲�����ʷ���ݼ����ֵ�ͱ�׼��Ŀ��ӻ�');
clearvars x k y;

%���ݿ��ӻ�-NH3-N-[mean4 std4]
figure
hold on
disp('# �����ڸ��۲�����ʷ���ݵľ�ֵ�ͱ�׼��');
disp(['     ��ֵ     ' '��׼��'])
for x = 1:17
    for k = 1:28
        y(k) = factors(x,4,k);
    end
    mean4(x) = mean(y);
    std4(x) = std(y);
    plot(repelem(x,28),y,'*');
end
disp(['     ��ֵ     ' '��׼��'])
disp([transpose(mean4) transpose(std4)])
plot(1:17,mean4);
plot(1:17,std4,'-.');
plot(1:0.1:17,repelem(0.15,161),'--')
plot(1:0.1:17,repelem(0.5,161),'--')
plot(1:0.1:17,repelem(1,161),'--')
plot(1:0.1:17,repelem(1.5,161),'--')
plot(1:0.1:17,repelem(2,161),'--')
hold off
xlabel('���б��');
ylabel('ָ����ֵ');
title('�����ڸ��۲�����ʷ���ݼ����ֵ�ͱ�׼��Ŀ��ӻ�');
clearvars x k y;

%���ݿ��ӻ�-NH3-N-[mean_l std_l]
figure
hold on
disp('# ��������������Ҫ�۲�վ��Ļ�������ˮ�����ľ�ֵ�ͱ�׼��');
disp(['     ��ֵ     ' '��׼��'])
for x = 1:7
    for k = 1:13
        y(k) = flow_l(k,x);
    end
    mean_l(x) = mean(y);
    std_l(x) = std(y);
    plot(repelem(x,13),y,'*');
end
disp(['     ��ֵ     ' '��׼��'])
disp([transpose(mean_l) transpose(std_l)])
plot(1:7,mean_l);
plot(1:7,std_l,'-.');
hold off
xlabel('�۲�վ���');
ylabel('�����۲�ֵ');
title('����������Ҫ�۲�վ��������Ŀ��ӻ�');
clearvars x k y;

%���ݿ��ӻ�-NH3-N-[mean_v std_v]
figure
hold on
disp('# ��������������Ҫ�۲�վ��Ļ�������ˮ���ٵľ�ֵ�ͱ�׼��');
disp(['     ��ֵ     ' '��׼��'])
for x = 1:7
    for k = 1:13
        y(k) = flow_v(k,x);
    end
    mean_v(x) = mean(y);
    std_v(x) = std(y);
    plot(repelem(x,13),y,'*');
end
disp(['     ��ֵ     ' '��׼��'])
disp([transpose(mean_v) transpose(std_v)])
plot(1:7,mean_v);
plot(1:7,std_v,'-.');
hold off
xlabel('�۲�վ���');
ylabel('���ٹ۲�ֵ');
title('����������Ҫ�۲�վ������ٵĿ��ӻ�');
clearvars x k y;
