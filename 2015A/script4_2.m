clear;
tic;

% 设置杆的坐标位置
points1 = zeros(100, 3);
points1(:,1) = 0;
points1(:,2) = 0;
points1(:,3) = transpose(linspace(0,2));
% 设置影子的坐标位置
shadow_len = 2;
shadow_x = 1.958;
points2 = zeros(100, 3);
points2(:,1) = transpose(linspace(0,shadow_x));
points2(:,2) = transpose(linspace(0,sqrt(shadow_len^2-shadow_x^2)));
points2(:,3) = 0;
% 设置中线的位置
points3 = zeros(100, 3);
points3(:,1) = 0;
points3(:,2) = transpose(linspace(0,-1.5));
points3(:,3) = 0;
R = 3.5;
D = 0.1;
angle1 = 0.3218; % φ
angle2 = -1.3798; % θ
T = [-sin(angle2) -cos(angle2)*sin(angle1) -cos(angle2)*cos(angle1) 0; cos(angle2) -sin(angle2)*sin(angle1) -sin(angle2)*cos(angle1) 0; 0 cos(angle1) -sin(angle1) 0; 0 0 R 1];

for k = 1:size(points1,1)
    xyzc = [points1(k,1) points1(k,2) points1(k,3) 1]*T;
    x0(k) = xyzc(1);
    y0(k) = xyzc(2);
    z0(k) = xyzc(3);
    c0(k) = xyzc(4);
end
xe = (x0./z0).*D;
ye = (y0./z0).*D;
plot(xe, ye, 'b')
hold on
for k = 1:size(points2,1)
    xyzc = [points2(k,1) points2(k,2) points2(k,3) 1]*T;
    x0(k) = xyzc(1);
    y0(k) = xyzc(2);
    z0(k) = xyzc(3);
    c0(k) = xyzc(4);
end
xe = (x0./z0).*D;
ye = (y0./z0).*D;
plot(xe, ye, 'k')
for k = 1:size(points3,1)
    xyzc = [points3(k,1) points3(k,2) points3(k,3) 1]*T;
    x0(k) = xyzc(1);
    y0(k) = xyzc(2);
    z0(k) = xyzc(3);
    c0(k) = xyzc(4);
end
xe = (x0./z0).*D;
ye = (y0./z0).*D;
plot(xe, ye, 'r')
hold off

toc;
