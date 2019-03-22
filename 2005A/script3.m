clear
clc

%����ȫ�ֱ���[year_num3 x_num]
year_num3 = 10;
grade_num = 6;
N = 4
foreYear_num = 10;

%��������[report]
report = zeros(9,13,10);
for k = 1:10
    num = xlsread('data.xlsx', 3, join(['C' sprintf('%d',6+(k-1)*14) ':O' sprintf('%d',14+(k-1)*14)]));
    report(:,:,k) = num;
end


%---------------------��ˮ��ȫ����---------------------%
%�������õ�������[lg_mat]
lg_mat = zeros(year_num3, grade_num);
for m = 1:year_num3
    for n = 1:grade_num
        lg_mat(m,n) = report(1, (2+2*(n-1)), m);
    end
end

%������������Ⱦ���ʱ�����п��ӻ�
figure('Name','��ˮ��ȫ����')
for k = 1:grade_num
    subplot(3,2,k)
    xi = 1:year_num3;
    yi = lg_mat(:,k);
    plot(xi, yi, '--')
    xlabel('ʱ��/��')
    ylabel(join([sprintf('%d',k) '��ˮ�ʵĿ�ˮ��ȫ����ӳ�/km']))
    title(join([sprintf('%d',k) '��ˮ����Ⱦ���ʱ������ͼ']))
end

%�������ƶ�ƽ����
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


%---------------------��ˮ�ڸ���---------------------%
%�������õ�������[lg_mat]
lg_mat = zeros(year_num3, grade_num);
for m = 1:year_num3
    for n = 1:grade_num
        lg_mat(m,n) = report(2, (2+2*(n-1)), m);
    end
end

%������������Ⱦ���ʱ�����п��ӻ�
figure('Name','��ˮ�ڸ���')
for k = 1:grade_num
    subplot(3,2,k)
    xi = 1:year_num3;
    yi = lg_mat(:,k);
    plot(xi, yi, '--')
    xlabel('ʱ��/��')
    ylabel(join([sprintf('%d',k) '��ˮ�ʵĿ�ˮ�ڸ����ӳ�/km']))
    title(join([sprintf('%d',k) '��ˮ����Ⱦ���ʱ������ͼ']))
end

%�������ƶ�ƽ����
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


%---------------------��ˮ��֧��--------------------%
%�������õ�������[lg_mat]
lg_mat = zeros(year_num3, grade_num);
for m = 1:year_num3
    for n = 1:grade_num
        lg_mat(m,n) = report(3, (2+2*(n-1)), m);
    end
end

%������������Ⱦ���ʱ�����п��ӻ�
figure('Name','��ˮ��֧��')
for k = 1:grade_num
    subplot(3,2,k)
    xi = 1:year_num3;
    yi = lg_mat(:,k);
    plot(xi, yi, '--')
    xlabel('ʱ��/��')
    ylabel(join([sprintf('%d',k) '��ˮ�ʵĿ�ˮ��֧���ӳ�/km']))
    title(join([sprintf('%d',k) '��ˮ����Ⱦ���ʱ������ͼ']))
end

%�������ƶ�ƽ����
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


%---------------------��ˮ��ȫ����---------------------%
%�������õ�������[lg_mat]
lg_mat = zeros(year_num3, grade_num);
for m = 1:year_num3
    for n = 1:grade_num
        lg_mat(m,n) = report(4, (2+2*(n-1)), m);
    end
end

%������������Ⱦ���ʱ�����п��ӻ�
figure('Name','��ˮ��ȫ����')
for k = 1:grade_num
    subplot(3,2,k)
    xi = 1:year_num3;
    yi = lg_mat(:,k);
    plot(xi, yi, '--')
    xlabel('ʱ��/��')
    ylabel(join([sprintf('%d',k) '��ˮ�ʵķ�ˮ��ȫ����ӳ�/km']))
    title(join([sprintf('%d',k) '��ˮ����Ⱦ���ʱ������ͼ']))
end

%�������ƶ�ƽ����
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


%---------------------��ˮ�ڸ���---------------------%
%�������õ�������[lg_mat]
lg_mat = zeros(year_num3, grade_num);
for m = 1:year_num3
    for n = 1:grade_num
        lg_mat(m,n) = report(5, (2+2*(n-1)), m);
    end
end

%������������Ⱦ���ʱ�����п��ӻ�
figure('Name','��ˮ�ڸ���')
for k = 1:grade_num
    subplot(3,2,k)
    xi = 1:year_num3;
    yi = lg_mat(:,k);
    plot(xi, yi, '--')
    xlabel('ʱ��/��')
    ylabel(join([sprintf('%d',k) '��ˮ�ʵķ�ˮ�ڸ����ӳ�/km']))
    title(join([sprintf('%d',k) '��ˮ����Ⱦ���ʱ������ͼ']))
end

%�������ƶ�ƽ����
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


%---------------------��ˮ��֧��---------------------%
%�������õ�������[lg_mat]
lg_mat = zeros(year_num3, grade_num);
for m = 1:year_num3
    for n = 1:grade_num
        lg_mat(m,n) = report(6, (2+2*(n-1)), m);
    end
end

%������������Ⱦ���ʱ�����п��ӻ�
figure('Name','��ˮ��֧��')
for k = 1:grade_num
    subplot(3,2,k)
    xi = 1:year_num3;
    yi = lg_mat(:,k);
    plot(xi, yi, '--')
    xlabel('ʱ��/��')
    ylabel(join([sprintf('%d',k) '��ˮ�ʵķ�ˮ��֧���ӳ�/km']))
    title(join([sprintf('%d',k) '��ˮ����Ⱦ���ʱ������ͼ']))
end

%�������ƶ�ƽ����
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


%---------------------ˮ����ȫ����---------------------%
%�������õ�������[lg_mat]
lg_mat = zeros(year_num3, grade_num);
for m = 1:year_num3
    for n = 1:grade_num
        lg_mat(m,n) = report(7, (2+2*(n-1)), m);
    end
end

%������������Ⱦ���ʱ�����п��ӻ�
figure('Name','ˮ����ȫ����')
for k = 1:grade_num
    subplot(3,2,k)
    xi = 1:year_num3;
    yi = lg_mat(:,k);
    plot(xi, yi, '--')
    xlabel('ʱ��/��')
    ylabel(join([sprintf('%d',k) '��ˮ�ʵ�ˮ����ȫ����ӳ�/km']))
    title(join([sprintf('%d',k) '��ˮ����Ⱦ���ʱ������ͼ']))
end

%�������ƶ�ƽ����
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


%---------------------ˮ�������---------------------%
%�������õ�������[lg_mat]
lg_mat = zeros(year_num3, grade_num);
for m = 1:year_num3
    for n = 1:grade_num
        lg_mat(m,n) = report(8, (2+2*(n-1)), m);
    end
end

%������������Ⱦ���ʱ�����п��ӻ�
figure('Name','ˮ�������')
for k = 1:grade_num
    subplot(3,2,k)
    xi = 1:year_num3;
    yi = lg_mat(:,k);
    plot(xi, yi, '--')
    xlabel('ʱ��/��')
    ylabel(join([sprintf('%d',k) '��ˮ�ʵ�ˮ��������ӳ�/km']))
    title(join([sprintf('%d',k) '��ˮ����Ⱦ���ʱ������ͼ']))
end

%�������ƶ�ƽ����
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


%---------------------ˮ����֧��---------------------%
%�������õ�������[lg_mat]
lg_mat = zeros(year_num3, grade_num);
for m = 1:year_num3
    for n = 1:grade_num
        lg_mat(m,n) = report(9, (2+2*(n-1)), m);
    end
end

%������������Ⱦ���ʱ�����п��ӻ�
figure('Name','ˮ����֧��')
for k = 1:grade_num
    subplot(3,2,k)
    xi = 1:year_num3;
    yi = lg_mat(:,k);
    plot(xi, yi, '--')
    xlabel('ʱ��/��')
    ylabel(join([sprintf('%d',k) '��ˮ�ʵ�ˮ����֧���ӳ�/km']))
    title(join([sprintf('%d',k) '��ˮ����Ⱦ���ʱ������ͼ']))
end

%�������ƶ�ƽ����
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
