clear;
clc;

%����ԭʼ����-[sourceData2]
sourceData2 = xlsread('E:\Users\dyk\Documents\Projects\��ѧ��ģ\��ģУ��\У����Ŀ\B�⸽��.xlsx', '����2-����������ʷ����', 'C3:H32');
sourceData3 = xlsread('E:\Users\dyk\Documents\Projects\��ѧ��ģ\��ģУ��\У����Ŀ\B�⸽��.xlsx', '����3-���������ˮƽ', 'C15:H44');

x_foreIn = 44018;
x_foreOut = 35377+500;

%д��Լ�������еĵ�ʽ�ľ���
Aeq = zeros(2, 120);
Aeq(1, 31:60) = 1;
beq(1, 1) = x_foreIn;
Aeq(2, 91:120) = 1;
beq(2, 1) = x_foreOut;

%�����ʡ�ݵ�ƽ��ֵ
for k = 1:30
    mean_rk_in(k) = mean(sourceData3(k, 1:2:6));
end
for k = 1:30
    mean_rk_out(k) = mean(sourceData3(k, 2:2:6));
end
%�������ʡ�ݵı�׼��
for k = 1:30
    std_rk_in(k) = std(sourceData3(k, 1:2:6));
end
for k = 1:30
    std_rk_out(k) = std(sourceData3(k, 2:2:6));
end
%д�����Ĳ��ȵ�Լ������
A1 = zeros(60, 120);
m = 1:30;
for k = 1:30
    A1(k, m(k)) = -1;
end
b1(1:30, 1) = 2*std_rk_in - mean_rk_in;
for k = 1:30
    A1(k+30, m(k)) = 1;
end
b1(31:60, 1) = 2*std_rk_in + mean_rk_in;
%����Ĳ���ʽ��Լ������
A2 = zeros(60, 120);
m = 61:90;
for k = 1:30
    A2(k, m(k)) = -1;
end
b2(1:30, 1) = 2*std_rk_out - mean_rk_out;
for k = 1:30
    A2(k+30, m(k)) = 1;
end
b2(31:60, 1) = 2*std_rk_out + mean_rk_out;

%�������л�׼����Լ������
A3 = zeros(60, 120);
m = 1:30;
for k = 1:30
    A3(k, m(k)) = -1;
end
b3(1:30, 1) = -1.35;
for k = 1:30
    A3(k+30, m(k)) = 1;
end
b3(31:60, 1) = 1.65;
%��������л�׼����Լ������
A4 = zeros(60, 120);
m = 61:90;
for k = 1:30
    A4(k, m(k)) = -1;
end
b4(1:30, 1) = -3.8;
for k = 1:30
    A4(k+30, m(k)) = 1;
end
b4(31:60, 1) = 5.7;

A = [A1; A2; A3; A4];
b = [b1; b2; b3; b4];
ri = transpose(mean_rk_in);
xi = sourceData2(:, 5) + (x_foreIn-sum(sourceData2(:, 5))) .* ((sourceData2(:, 5)/sum(sourceData2(:, 5))));
ro = transpose(mean_rk_out);
xo = sourceData2(:, 6) + (x_foreOut-sum(sourceData2(:, 6))) .* ((sourceData2(:, 6)/sum(sourceData2(:, 6))));
x0 = [ri; xi; ro; xo];
[x, y] = fmincon('function_b3_1', x0, A, b, Aeq, beq, zeros(120, 0), []);
xlswrite('report.xlsx', [x(31:60) x(91:120)], 3, 'A1');

disp('# ���䷽��');
disp('������� ����� �������� ������');
disp([x(1:30) x(31:60) x(61:90) x(91:120)]);
disp(-y);
