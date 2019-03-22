clear
tic; % �������м�ʱ

% ��������
points = xlsread('����1-3.xls', '����1', 'B4:C24');
angle0 = 7.0679;

% ʵ������Ĳ�������
h = 3; % ����˵ĸ߶�Ϊ3��
days = datenum([2015 4 18])-datenum([2015 3 21]); % ����Ŀ��֪����
solar = ((23.5*sin(((2*pi)/365)*days))/360)*(2*pi); % ����Ŀ��֪����
t = [220.5 235.5]; % ʱ����������Ƕ���
rad_t = (t/360)*(2*pi); % ʱ���������������

% �����㷨����
E0 = 0.01; % �������
maxNum = 5000; % ��������������
narvs = 1; % Ŀ�꺯�����Ա�������
particleSize = 50; % ����Ⱥ��ģ
c1 = 2; % ÿ�����ӵĸ���ѧϰ���ӣ�Ҳ�Ƽ��ٳ���
c2 = 2; % ÿ�����ӵ����ѧϰ���ӣ�Ҳ�Ƽ��ٳ���
w = 0.6; % ��������
vMax = 27; % ���ӵ��������ٶȣ���λ����/�Ρ�

for v0 = 1:60
    % ��ʼ������Ⱥ״̬
    x = 180*(rand(particleSize, narvs)-0.5); % ���ӵ�����λ�ã���λ���ȡ�
    v = v0*rand(particleSize,narvs); % ���ӵķ����ٶȣ���λ����/�Ρ�

    for m = 1:particleSize
        for n = 1:narvs
            rad_x = (x(m,n)/360)*(2*pi); % ���Ƕ��Ƶ�xת��Ϊ�����Ƶ�rad_x
            sin_h = sin(rad_x).*sin(solar)+cos(rad_x).*cos(solar).*cos(rad_t);
            cos_h = sqrt(1-sin_h.^2);
            cos_dir_rad1 = (sin(solar)-sin_h(1)*sin(rad_x))/(cos_h(1)*cos(rad_x));
            cos_dir_rad2 = (sin(solar)-sin_h(2)*sin(rad_x))/(cos_h(2)*cos(rad_x));
            y(m) = abs((abs(acos(cos_dir_rad1)-acos(cos_dir_rad2))/(2*pi))*360-angle0);
        end
    end
    personalBest_x = x;
    personalBest_faval = y;
    [globalBest_faval m] = min(personalBest_faval);
    globalBest_x = personalBest_x(m,:);
    k = 1;
    while k<=maxNum
        for m = 1:particleSize
            for n = 1:narvs
                rad_x = (x(m,n)/360)*(2*pi); % ���Ƕ��Ƶ�xת��Ϊ�����Ƶ�rad_x
                sin_h = sin(rad_x).*sin(solar)+cos(rad_x).*cos(solar).*cos(rad_t);
                cos_h = sqrt(1-sin_h.^2);
                cos_dir_rad1 = (sin(solar)-sin_h(1)*sin(rad_x))/(cos_h(1)*cos(rad_x));
                cos_dir_rad2 = (sin(solar)-sin_h(2)*sin(rad_x))/(cos_h(2)*cos(rad_x));
                y(m) = abs((abs(acos(cos_dir_rad1)-acos(cos_dir_rad2))/(2*pi))*360-angle0);
            end
            if y(m)<personalBest_faval % �жϵ�ǰλ���Ƿ�����ʷ�����λ��
                personalBest_faval(m) = y(m);
                personalBest_x(m,:) = x(m,:);
            end
        end
        [globalBest_faval m] = min(personalBest_faval);
        globalBest_x = personalBest_x(m,:);
        for m = 1:particleSize % ��������Ⱥ��ÿ�����������λ��
            v(m,:) = w*v(m,:)+c1*rand*(personalBest_x(m,:)-x(m,:))+c2*rand*(globalBest_x-x(m,:));
            for n = 1:narvs % �ж����ӵķ����ٶ��Ƿ񳬹��������ٶ�
                if v(m,n)>vMax
                    v(m,n) = vMax;
                elseif v(m,n)<-vMax
                    v(m,n) = -vMax;
                end
            end
            x(m,:) = x(m,:)+v(m,:);
        end
        if abs(globalBest_faval)<E0
            break
        end
        k = k+1;
    end
    globalBest_favals(v0) = globalBest_faval;
    globalBest_xs(v0) = globalBest_x;
    globalBest_favals_rad(v0) = globalBest_faval + angle0;
end
plot(1:v0, globalBest_favals, 'b')
hold on
plot(1:v0, globalBest_xs, 'r')
hold off
toc;
