clear

solar_angle = 0; % 太阳赤纬
time = [9 0 0]; % 地方时间[时 分 秒]
direction = 1; % 北纬是1，南纬是-1
dimension = [39 54 26]; % 杆的纬度，由[度 分 秒]组成
len_staff = 3; % 杆的长度(米)

for days = 1:365
    solar_angle = ((23.50*sin(((2*pi)/365)*days))/360)*(2*pi); % 由日期计算太阳赤纬，精确到小数点后两位，北纬是正的，南纬是负的，弧度制
    time_angle = ((15*time(1)+(15*time(2))/60+((15*time(3))/60)*0.1)/360)*(2*pi)-pi; % 计算出时角，精确到小数点后两位，弧度制
    dimension_angle = direction*(((dimension(1)+dimension(2)/60+(dimension(3)/60)*0.1)/360)*(2*pi)); % 计算维度，精确到小数点后两位，北纬是正的，南纬是负的，弧度制
    sin_altitude_angle = sin(dimension_angle)*sin(solar_angle)+cos(dimension_angle)*cos(solar_angle)*cos(time_angle); % 求太阳高度角的正弦值
    cos_altitude_angle = sqrt(1-sin_altitude_angle^2); % 求太阳高度角的余弦值
    len_shadow(days) = len_staff*(cos_altitude_angle/sin_altitude_angle); % 求杆的影子长度(米)
end
plot(1:365, len_shadow)
title('上午九点、物体的纬度为39°54′26″时，太阳赤纬随着日期的推移而变化导致的3米长的杆的影子的变化图')
