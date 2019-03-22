clear;
tic;

% ʵ������Ĳ�������
angle0 = 7.0679;
h = 3; % ����˵ĸ߶�Ϊ3��
days = datenum([2015 4 18])-datenum([2015 3 21]); % ����Ŀ��֪����
solar = ((23.5*sin(((2*pi)/365)*days))/360)*(2*pi); % ����Ŀ��֪����
t0 = [220.5 235.5]; % ʱ����������Ƕ���
rad_t0 = (t0/360)*(2*pi); % ʱ���������������

% �����㷨����
E0 = 0.05; % �������
maxNum = 10000; % ��������������
narvs = 2; % Ŀ�꺯�����Ա�������
particleSize = 100; % ����Ⱥ��ģ
c1 = 2; % ÿ�����ӵĸ���ѧϰ���ӣ�Ҳ�Ƽ��ٳ���
c2 = 2; % ÿ�����ӵ����ѧϰ���ӣ�Ҳ�Ƽ��ٳ���
w = 0.6; % ��������
vMax = 27; % ���ӵ��������ٶȣ���λ����/�Ρ�

for v0 = 1:90
    % ��ʼ������Ⱥ״̬
    x = zeros(particleSize, narvs);
    x(:,1) = 180*(rand(particleSize,1)-0.5); % ���ӵ�����ά�ȣ���λ���ȡ�
    x(:,2) = 360*(rand(particleSize,1)-0.5); % ���ӵ����ھ��ȣ���λ���ȡ�
    v = zeros(particleSize, narvs);
    v(:,1) = v0*rand(particleSize,1); % �������ڵ�ά�ȵķ����ٶȣ���λ����/�Ρ�
    v(:,2) = 2*v0*rand(particleSize,1); % �������ڵľ��ȵķ����ٶȣ���λ����/�Ρ�

    for m = 1:particleSize
        rad_x = (x(m,1)./360).*(2*pi); % ��γ�ȽǶ��Ƶ�xת��Ϊ�����Ƶ�rad_x
        t = t0 + (x(m,2)-120); % �������ά������Ӧ��ʵ�ʵ�ʱ���
        rad_t = (t./360).*(2*pi); % ��x�ľ��ȶ�Ӧ��ʱ���ת��Ϊ������rad_t
        sin_h = sin(rad_x(1)).*sin(solar)+cos(rad_x(1)).*cos(solar).*cos(rad_t);
        cos_h = sqrt(1-sin_h.^2);
        cos_dir1 = (sin(solar)-sin_h(1)*sin(x(m,1)))/(cos_h(1)*cos(x(m,1)));
        cos_dir2 = (sin(solar)-sin_h(2)*sin(x(m,1)))/(cos_h(2)*cos(x(m,1)));
        y(m) = abs(abs((acos(cos_dir1)/(2*pi))*360-(acos(cos_dir2)/(2*pi))*360)-angle0);
    end
    personalBest_x = x;
    personalBest_faval = y;
    [globalBest_faval m] = min(personalBest_faval);
    globalBest_x = personalBest_x(m,:);
    k = 1;
    while k<=maxNum
        for m = 1:particleSize
            rad_x = (x(m,1)./360).*(2*pi); % ��γ�ȽǶ��Ƶ�xת��Ϊ�����Ƶ�rad_x
            t = t0 + (x(m,2)-120); % �������ά������Ӧ��ʵ�ʵ�ʱ���
            rad_t = (t./360).*(2*pi); % ��x�ľ��ȶ�Ӧ��ʱ���ת��Ϊ������rad_t
            sin_h = sin(rad_x(1)).*sin(solar)+cos(rad_x(1)).*cos(solar).*cos(rad_t);
            cos_h = sqrt(1-sin_h.^2);
            cos_dir1 = (sin(solar)-sin_h(1)*sin(x(m,1)))/(cos_h(1)*cos(x(m,1)));
            cos_dir2 = (sin(solar)-sin_h(2)*sin(x(m,1)))/(cos_h(2)*cos(x(m,1)));
            y(m) = abs((acos(cos_dir1)/(2*pi))*360-(acos(cos_dir2)/(2*pi))*360);
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
    globalBest_xs(v0,:) = globalBest_x;
end
plot(1:v0, globalBest_favals, 'b')
hold on
plot(1:v0, globalBest_xs(:,1), 'm')
plot(1:v0, globalBest_xs(:,2), 'r')
hold off
toc;
