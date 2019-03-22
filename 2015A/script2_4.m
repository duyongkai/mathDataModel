clear;
tic;

% 导入数据
points = xlsread('附件1-3.xls', '附件1', 'B4:C24');
l0 = transpose(sqrt(points(:,1).^2+points(:,2).^2));

% 实际问题的参数设置
h = 1; % 假设杆的高度为3米
days = datenum([2015 4 18])-datenum([2015 3 21]); % 由题目已知计算
solar = ((23.5*sin(((2*pi)/365)*days))/360)*(2*pi); % 由题目已知计算
t0 = [220.5 221.25 222 222.75 223.5 224.25 225 225.75 226.5 227.25 228 228.75 229.5 230.25 231 231.75 232.5 233.25 234 234.75 235.5]; % 时间角向量，角度制
rad_t0 = (t0/360)*(2*pi); % 时间角向量，弧度制

% 设置算法参数
E0 = 0; % 允许误差
maxNum = 1000; % 粒子最大迭代次数
narvs = 2; % 目标函数的自变量个数
particleSize = 100; % 粒子群规模
c1 = 2; % 每个粒子的个体学习因子，也称加速常数
c2 = 2; % 每个粒子的社会学习因子，也称加速常数
w = 0.6; % 惯性因子
vMax = 27; % 粒子的最大飞行速度，单位“度/次”
p = 0;
for h = 1:0.1:3
    for v0 = 1:90
        % 初始化粒子群状态
        x = zeros(particleSize, narvs);
        x(:,1) = 180*(rand(particleSize,1)-0.5); % 粒子的所在维度，单位“度”
        x(:,2) = 360*(rand(particleSize,1)-0.5); % 粒子的所在经度，单位“度”
        v = v0*rand(particleSize,narvs); % 粒子的飞行速度，单位“度/次”

        for m = 1:particleSize
            rad_x = (x(m,1)./360).*(2*pi); % 将纬度角度制的x转换为弧度制的rad_x
            t = t0 + (x(m,2)-120); % 计算各个维度所对应的实际的时间角
            rad_t = (t./360).*(2*pi); % 将x的经度对应的时间角转换为弧度制rad_t
            sin_h = sin(rad_x(1)).*sin(solar)+cos(rad_x(1)).*cos(solar).*cos(rad_t);
            cos_h = sqrt(1-sin_h.^2);
            l = h.*(cos_h./sin_h);
            y(m) = sum(abs(l-l0));
        end
        personalBest_x = x;
        personalBest_faval = y;
        [globalBest_faval m] = min(personalBest_faval);
        globalBest_x = personalBest_x(m,:);
        k = 1;
        while k<=maxNum
            for m = 1:particleSize
                rad_x = (x(m,1)./360).*(2*pi); % 将纬度角度制的x转换为弧度制的rad_x
                t = t0 + (x(m,2)-120); % 计算各个维度所对应的实际的时间角
                rad_t = (t./360).*(2*pi); % 将x的经度对应的时间角转换为弧度制rad_t
                sin_h = sin(rad_x(1)).*sin(solar)+cos(rad_x(1)).*cos(solar).*cos(rad_t);
                cos_h = sqrt(1-sin_h.^2);
                l = h.*(cos_h./sin_h);
                y(m) = sum(abs(l-l0));
                if y(m)<personalBest_faval % 判断当前位置是否是历史上最佳位置
                    personalBest_faval(m) = y(m);
                    personalBest_x(m,:) = x(m,:);
                end
            end
            [globalBest_faval m] = min(personalBest_faval);
            globalBest_x = personalBest_x(m,:);
            for m = 1:particleSize % 更新粒子群里每个个体的最新位置
                v(m,:) = w*v(m,:)+c1*rand*(personalBest_x(m,:)-x(m,:))+c2*rand*(globalBest_x-x(m,:));
                for n = 1:narvs % 判断粒子的飞行速度是否超过最大飞行速度
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
    p = p+1;
    min_globalBest_favals(p) = min(globalBest_favals);
end
plot(1:p, min_globalBest_favals)
toc;
