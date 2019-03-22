clear
clc

%����ȫ�ֱ���
month_num2 = 13;
city_num2 = 7;
p = 0.2;

%��������[COOMn l v s]
COOMn = zeros(month_num2, city_num2);
NH3N = zeros(month_num2, city_num2);
l = zeros(month_num2,city_num2);
v = zeros(month_num2,city_num2);
s = [950 778 395 500 164 464];
for k = 1:month_num2
    COOMn(k,:) = xlsread('data.xlsx', 1, join(['F' sprintf('%d',7+21*(k-1)) ':F' sprintf('%d',13+21*(k-1))]));
end
for k = 1:month_num2
    NH3N(k,:) = xlsread('data.xlsx', 1, join(['G' sprintf('%d',7+21*(k-1)) ':G' sprintf('%d',13+21*(k-1))]));
end
for k = 1:month_num2
    num = xlsread('data.xlsx', 2, join(['C' sprintf('%d',5+(k-1)*2) ':I' sprintf('%d',5+(k-1)*2)]));
    l(k,:) = num;
end
for k = 1:month_num2
    num = xlsread('data.xlsx', 2, join(['C' sprintf('%d',6+(k-1)*2) ':I' sprintf('%d',6+(k-1)*2)]));
    v(k,:) = num;
end
clearvars k num;

%-----------------------COOMn-----------------------%
locals_c_mat = zeros(month_num2, city_num2);
for month_num = 1:month_num2
    locals_c = [COOMn(month_num,1) 0 0 0 0 0 0];
    for k = 2:city_num2
        day_num = (s(k-1)*1000)/mean([v(k) v(k-1)])/86400; %��
        water_abs = day_num*(86400*mean([l(k) l(k-1)])); %m? �м���
        reduce_abs = p*COOMn(month_num,k-1)*day_num*water_abs; %g �м��裬����Ϊʲô���û���
        last_abs = COOMn(month_num,k-1)*water_abs - reduce_abs; %g �м������last_abs<0˵����������������Լ���������������������;������
        local_abs = COOMn(month_num,k)*water_abs - last_abs; %g
        locals_c(k) = local_abs/water_abs; %g/m?
    end
    locals_c_mat(month_num,:) = locals_c;
end
S_locals_c = locals_c_mat./std(locals_c_mat);
mean_locals_c = mean(S_locals_c);
disp('# ���۲�վ������COOMnŨ�ȵ�ȥ��ɢ��֮���ƽ��ֵ')
disp(mean_locals_c)
figure('Name','COOMn')
plot(1:city_num2, mean_locals_c)

%-----------------------NH3-N-----------------------%
locals_c_mat = zeros(month_num2, city_num2);
for month_num = 1:month_num2
    locals_c = [NH3N(month_num,1) 0 0 0 0 0 0];
    for k = 2:city_num2
        day_num = (s(k-1)*1000)/mean([v(k) v(k-1)])/86400; %��
        water_abs = day_num*(86400*mean([l(k) l(k-1)])); %m? �м���
        reduce_abs = p*NH3N(month_num,k-1)*day_num*water_abs; %g �м��裬����Ϊʲô���û���
        last_abs = NH3N(month_num,k-1)*water_abs - reduce_abs; %g �м������last_abs<0˵����������������Լ���������������������;������
        local_abs = NH3N(month_num,k)*water_abs - last_abs; %g
        locals_c(k) = local_abs/water_abs; %g/m?
    end
    locals_c_mat(month_num,:) = locals_c;
end
S_locals_c = locals_c_mat./std(locals_c_mat);
mean_locals_c = mean(S_locals_c);
disp('# ���۲�վ������NH3-NŨ�ȵ�ȥ��ɢ��֮���ƽ��ֵ')
disp(mean_locals_c)
figure('Name','NH3-N')
plot(1:city_num2, mean_locals_c)
