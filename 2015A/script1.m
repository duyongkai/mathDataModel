clear

solar_angle = 0; % ̫����γ
time = [9 0 0]; % �ط�ʱ��[ʱ �� ��]
direction = 1; % ��γ��1����γ��-1
dimension = [39 54 26]; % �˵�γ�ȣ���[�� �� ��]���
len_staff = 3; % �˵ĳ���(��)

for days = 1:365
    solar_angle = ((23.50*sin(((2*pi)/365)*days))/360)*(2*pi); % �����ڼ���̫����γ����ȷ��С�������λ����γ�����ģ���γ�Ǹ��ģ�������
    time_angle = ((15*time(1)+(15*time(2))/60+((15*time(3))/60)*0.1)/360)*(2*pi)-pi; % �����ʱ�ǣ���ȷ��С�������λ��������
    dimension_angle = direction*(((dimension(1)+dimension(2)/60+(dimension(3)/60)*0.1)/360)*(2*pi)); % ����ά�ȣ���ȷ��С�������λ����γ�����ģ���γ�Ǹ��ģ�������
    sin_altitude_angle = sin(dimension_angle)*sin(solar_angle)+cos(dimension_angle)*cos(solar_angle)*cos(time_angle); % ��̫���߶Ƚǵ�����ֵ
    cos_altitude_angle = sqrt(1-sin_altitude_angle^2); % ��̫���߶Ƚǵ�����ֵ
    len_shadow(days) = len_staff*(cos_altitude_angle/sin_altitude_angle); % ��˵�Ӱ�ӳ���(��)
end
plot(1:365, len_shadow)
title('����ŵ㡢�����γ��Ϊ39��54��26��ʱ��̫����γ�������ڵ����ƶ��仯���µ�3�׳��ĸ˵�Ӱ�ӵı仯ͼ')
